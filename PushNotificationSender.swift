//
//  PushNotificationSender.swift
//  NotificationDemo
//
//  Created by Yogesh Raj on 10/08/22.
//

import UIKit

class PushNotificationSender {
    func sendPushNotification(to token: [String], title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["registration_ids" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]

        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAE70uDvM:APA91bGHNOal3Q1UVyBnjeyFeNNGDqAX_7ap3FGT78IsFftoYh84Yr72oZeT-tBPDjD5DcsyF8WNFivl2OcXtP3gVJXmgD5E7UipJpwdTIsSqqWgjsTuqQ4pWRW041cQp1v7C7gRlpgB", forHTTPHeaderField: "Authorization")

        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
