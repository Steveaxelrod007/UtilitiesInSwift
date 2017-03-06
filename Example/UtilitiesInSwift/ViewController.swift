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

override func viewDidLoad() 
{
 super.viewDidLoad()
 SendLocalAlert.sendLocalAlert(delaySeconds: 10, title: "Test", subTitle: "Test", msg: "Test")
 let num = "123,456.78"
 print("Origial number --> \(num)   \(NumberToWords.convert(amount: num))")
 Queues.delayThenRunMainQueue(delay: 3) 
   {
   print("delayed in queue") 
   }
 
 print("Available device space --> \(FileSystem.availableDeviceSpace())")    
}


override func didReceiveMemoryWarning() 
{
 super.didReceiveMemoryWarning()
}


}

