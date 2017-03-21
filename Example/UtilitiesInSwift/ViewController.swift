//
//  ViewController.swift
//  UtilitiesInSwift
//
//  Created by steveaxelrod007 on 03/06/2017.
//  Copyright (c) 2017 steveaxelrod007. All rights reserved.
//

import UIKit
import UtilitiesInSwift


class ViewController: UIViewController 
{
var cc = CancelableClosure()       // axe maintain the var
var autoComplete:AutoFillTextField?

@IBOutlet weak var textF: UITextField!


@IBAction func textFieldChanged() 
{
}


func tests()
{
 SendLocalAlert.sendLocalAlert(delaySeconds: 10, title: "Test", subTitle: "Test", msg: "Test")
 
 let num = "123,456.78"
 print("Origial number --> \(num)   \(NumberToWords.convert(amount: num))")

 
 let start = Date().timeIntervalSince1970
 Queues.delayThenRunMainQueue(delay: 2) 
   {
   print("delayed in queue --> \(Date().timeIntervalSince1970 - start)") 
   }
 

 print("Available device space --> \(FileSystem.availableDeviceSpace())")

 
 print("Phone is in use --> \(Phone.onPhone())")        

       
 cc.cancelled = true
        
 let newCc = CancelableClosure()  
 newCc.closure =
   { //[weak self] in
   print("closure called")
   }

 cc = newCc
 cc.runAfterDelayOf(delayTime: 1.5)


 let color = UIColor.init(red: 10, green: 20, blue: 30)
 print("Int value of color --> \(UIColor.hexFromColor(color: color))")
 print("UIColor from Int --> \(UIColor.colorWithHex(hex: UIColor.hexFromColor(color: color)))")

 
 for intVal in [10000, 50000, 100000, 1000000, 10000000, (5280 * 1000) - 1, (5280 * 1000), 999999,999990,999900]
     {
     print(intVal.distance())
     print(intVal.fullNotation())
     print(intVal.kmNotation())
     print("------------")
     }
}


override func viewDidLoad() 
{
 super.viewDidLoad()

 let listOfNames = [
                   AutoFillTextFieldData(name: "abc", imageUrl: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_1440,q_90,w_720/v1/188519/dad_dhrmcu.png"),
                   AutoFillTextFieldData(name: "frefreabc", imageUrl: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_1440,q_90,w_720/v1/188519/2_tzg2hp.png"),
                   AutoFillTextFieldData(name: "rregergabc", imageUrl: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_1440,q_90,w_720/v1/188519/IMG_2592_d1xth2.png"),
                   AutoFillTextFieldData(name: "agregrtegbc", imageUrl: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_1440,q_90,w_720/v1/188519/Image-1_tvf0ka.jpg"),
                   AutoFillTextFieldData(name: "etrhtrhtrgerghabc", imageUrl: "http://www.axelrod.net/guruspot.jpg"),
                   AutoFillTextFieldData(name: "ztrhtrgregrrhthabc", imageUrl: "http://www.axelrod.net/horizon.jpg"),
                   AutoFillTextFieldData(name: "htrhtrwwqswqhthabc", imageUrl: "http://www.axelrod.net/jamfeed.jpg"),
                   AutoFillTextFieldData(name: "abtrhwdwqdtrhthabc", imageUrl: "http://www.axelrod.net/poi.jpg"),
                   AutoFillTextFieldData(name: "qwdwdtrhtrhthabc", imageUrl: "http://www.axelrod.net/superchat.jpg"),
                   AutoFillTextFieldData(name: "iabc", imageUrl: "http://www.axelrod.net/safetynet1.PNG"),
                   AutoFillTextFieldData(name: "hfrefreabc", imageUrl: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_1440,q_90,w_720/v1/188519/2_tzg2hp.png"),
                   AutoFillTextFieldData(name: "grregergabc", imageUrl: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_1440,q_90,w_720/v1/188519/IMG_2592_d1xth2.png"),
                   AutoFillTextFieldData(name: "fagregrtegbc", imageUrl: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_1440,q_90,w_720/v1/188519/Image-1_tvf0ka.jpg"),
                   AutoFillTextFieldData(name: "eetrhtrhtrgerghabc", imageUrl: "http://www.axelrod.net/guruspot.jpg"),
                   AutoFillTextFieldData(name: "dztrhtrgregrrhthabc", imageUrl: "http://www.axelrod.net/horizon.jpg"),
                   AutoFillTextFieldData(name: "chtrhtrwwqswqhthabc", imageUrl: "http://www.axelrod.net/jamfeed.jpg"),
                   AutoFillTextFieldData(name: "babtrhwdwqdtrhthabc", imageUrl: "http://www.axelrod.net/poi.jpg"),
                   AutoFillTextFieldData(name: "aqwdwdtrhtrhthabc", imageUrl: "http://www.axelrod.net/superchat.jpg"),
                   ]
 
 autoComplete = AutoFillTextField(triggers: "@+*", textF: textF, view: view, list: listOfNames)
}


override func viewDidAppear(_ animated: Bool)
{
 super.viewDidAppear(animated)
 tests()
}


override func didReceiveMemoryWarning() 
{
 super.didReceiveMemoryWarning()
}


}

