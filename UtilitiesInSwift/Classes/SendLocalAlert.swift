// axee.com by Steve Axelrod

import Foundation
import UserNotifications
import UserNotificationsUI


public class SendLocalAlert
{

@available(iOS 10.0, *)
public class func sendLocalAlert(delaySeconds: Int, title: String, subTitle: String, msg: String)
{
 let center = UNUserNotificationCenter.current()   
 center.requestAuthorization(options: [.alert, .sound])  // axe the request should have already been done in your project 
   { (granted, error) in
   if granted
      {
      let content = UNMutableNotificationContent()
      
      content.title    = title
      content.subtitle = subTitle
      content.body     = msg 
      content.sound    = UNNotificationSound.default()
     
      let trigger  = UNTimeIntervalNotificationTrigger.init(timeInterval: TimeInterval(delaySeconds > 0 ? delaySeconds : 1), repeats: false)
      let uniqueID = ProcessInfo.processInfo.globallyUniqueString.replacingOccurrences(of: "-", with: "")
      let request  = UNNotificationRequest(identifier: uniqueID, content: content, trigger: trigger)
             
      UNUserNotificationCenter.current().add(request)
        { (error) in
        print(error?.localizedDescription ?? "")
        }
      }
   }
}


@available(iOS 10.0, *)
public func shutOffAllLocalNotifications()
{
 UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
}

} 
