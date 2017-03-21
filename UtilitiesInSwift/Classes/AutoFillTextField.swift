// axee.com by Steve Axelrod

import Foundation
import UIKit


public struct AutoFillTextFieldData
{
var name = ""
var imageUrl = ""

 
public init(name: String, imageUrl: String)
{
 self.name = name
 self.imageUrl = imageUrl
}
 
}


public class AutoFillTextField: NSObject, UITableViewDelegate, UITableViewDataSource
{
weak var textF: UITextField?
weak var view: UIView?

var tableV: UITableView?

var list = [AutoFillTextFieldData]()
var filteredList = [AutoFillTextFieldData]() 

var triggers   = ""

var inLookupMode = false

var indexOfTrigger = 0
var backColor: UIColor?
var textColor: UIColor?

var callBack: (() -> Void)?
var cancelC = CancelableClosure()


public init(triggers: String, textF: UITextField, view: UIView, list: [AutoFillTextFieldData], tableView: UITableView? = nil, backColor: UIColor? = nil, textColor: UIColor? = nil, callBack: (() -> Void)? = nil)
{
 super.init()

 self.triggers   = triggers
 self.textF      = textF
 self.view       = view
 self.backColor  = backColor
 self.textColor  = textColor
 self.callBack   = callBack
 
 if let tableView = tableView
    {
    self.tableV = tableView
    }
 else
    {
    tableV = UITableView()
    tableV?.frame = CGRect(x: 0, y: 40, width: view.frame.width, height: view.frame.height - textF.frame.origin.y - textF.frame.size.height - 40)
    if let backColor = backColor { tableV?.backgroundColor = backColor }
    }

 tableV?.delegate   = self
 tableV?.dataSource = self
 tableV?.register(UITableViewCell.self, forCellReuseIdentifier: "axeCell")
 tableV?.tableFooterView = UIView() // axe hides blank rows

 setupLists(list: list)       
 self.list.removeAll()
 self.list.append(contentsOf: list)
 self.list.sort 
   { (f1, f2) -> Bool in
   f1.name < f2.name
   }
   
 textF.addTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged)
}


private func setupLists(list: [AutoFillTextFieldData])
{
 self.list.removeAll()
 self.list.append(contentsOf: list)
 self.list.sort 
   { (f1, f2) -> Bool in
   f1.name < f2.name
   }
}


public func updateList(list: [AutoFillTextFieldData])
{
 Queues.dispatchMainQueueAsync 
   { [weak self] in
   self?.setupLists(list: list)
   self?.filteredList.removeAll()
   self?.filteredList.append(contentsOf: self?.list ?? [])
   self?.tableV?.reloadData()
   }
}


private func trigger() -> Bool
{
// print(">\(textF?.text ?? "")<")
 if let chr = textF?.text?.characters.last
    {
    if triggers.contains(String(chr))
       {
       if textF?.text?.characters.count == 1 { return true }

       guard let txt = textF?.text else { return false }
       if txt.substring(from:txt.index(txt.endIndex, offsetBy: -2)) == " \(chr)" { return true }
       }
    }  
    
 return false    
}


private func checkCancelable()
{
 guard let callBack = callBack else { return }

 cancelC.cancelled = true
 
 let cancel = CancelableClosure()
 cancel.closure =
   {
   callBack()
   }
 
 cancelC = cancel
 
 cancelC.runAfterDelayOf()      
}



@objc private func textChanged()
{
 checkCancelable()   
 
// print("\(Date().timeIntervalSince1970)  >\(textF?.text ?? "")< inlook --> \(inLookupMode)    index --> \(indexOfTrigger)   trigger --> \(trigger())")
 if trigger() { lookupOff() } 
// print("\(Date().timeIntervalSince1970)  >\(textF?.text ?? "")< inlook --> \(inLookupMode)    index --> \(indexOfTrigger)   trigger --> \(trigger())")
 
 if inLookupMode
    {
    if indexOfTrigger < (textF?.text?.characters.count ?? 0)
       {
       guard let txt = textF?.text else { return }
       let subS = txt.substring(from:txt.index(txt.endIndex, offsetBy: -(txt.characters.count - indexOfTrigger - 1))) // axe remove trigger char

       filteredList = list.filter({ (item) -> Bool in return item.name.hasPrefix(subS) })

       tableV?.isHidden = filteredList.count < 1                        
       tableV?.reloadData()
       }
    else
       {
       lookupOff()
       }   
    }   


 if trigger() && inLookupMode == false
    {
    if let text = textF?.text { indexOfTrigger = text.characters.count - 1 }
    startTableLookup()
    }  
}


private func startTableLookup()
{
 guard let view   = view   else { return }
 guard let tableV = tableV else { return }
 
 tableV.isHidden = false

 view.addSubview(tableV)
 
 filteredList.append(contentsOf: list)
 tableV.reloadData()
 
 inLookupMode = true
}


public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
{
 return filteredList.count
}


public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
{
 let cell = tableView.dequeueReusableCell(withIdentifier: "axeCell", for: indexPath)
         
 cell.imageView?.image     = nil  // axe initialize cell
 cell.backgroundColor      = self.backColor
 cell.textLabel?.textColor = self.textColor

 cell.textLabel?.text = filteredList[indexPath.row].name

 if filteredList[indexPath.row].imageUrl.characters.count > 0, let url = URL(string: filteredList[indexPath.row].imageUrl)
    {
    let cel = cell
    cel.imageView?.image = UIImage(named: "placeholder")  // axe place holder image
    Queues.dispatchBackgroundQueueASync 
      {
      if let data = try? Data(contentsOf: url) 
         {
         if let image = UIImage(data: data)
            {
            Queues.dispatchMainQueueAsync
              { 
              cel.imageView?.image = image
              }
            }
         }
      }
    }    
        
 return cell
}


public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
{
 if let textF = textF, let txt = textF.text 
    {
    textF.text = txt + filteredList[indexPath.row].name + " "
    }

 lookupOff()
}


private func lookupOff()
{
 tableV?.removeFromSuperview()
 inLookupMode = false
 indexOfTrigger = 0

 filteredList.removeAll()
 
 cancelC.cancelled = true
}


public func close()
{
 lookupOff()
 
 textF?.removeTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged)
 textF  = nil
 view   = nil    
}


deinit
{
 close()
}


}
