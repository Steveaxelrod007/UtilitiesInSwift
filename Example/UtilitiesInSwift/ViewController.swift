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

 
 for intVal in [10000, 50000, 100000, 1000000, 10000000, (5280 * 1000) - 1, (5280 * 1000)]
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

