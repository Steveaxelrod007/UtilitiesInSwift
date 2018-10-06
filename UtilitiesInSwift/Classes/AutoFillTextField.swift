// axee.com by Steve Axelrod

import Foundation
import UIKit


public struct AutoFillTextFieldData   // axe this can be expanded as needed for more items to display in table
{
var name = ""
var imageUrl = ""
var image: UIImage?
 
public init(name: String, imageUrl: String, image:UIImage? = nil)
{
 self.name     = name
 self.imageUrl = imageUrl
 self.image    = image 
}
 
}


public class AutoFillTextField: NSObject, UITableViewDelegate, UITableViewDataSource
{
weak var textF: UITextField?
weak var view: UIView?

var tableV: UITableView?

var list         = [AutoFillTextFieldData]()  // axe initial list to display
var filteredList = [AutoFillTextFieldData]()  // axe actual list to display based on 'list', gets set when table is displayed and modified as user types
var imageList    = [AutoFillTextFieldData]()  // axe cache of already loaded images

var triggers   = ""
var indexOfTrigger = 0

var inLookupMode = false

var backColor: UIColor?
var textColor: UIColor?

var callBack: (() -> Void)?         // axe a nice way for a server call to be made after key strokes, 0.5 seconds delay and resets
var cancelC = CancelableClosure()

var cellTagID = 0  // axe used for loading correct image when in background 


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
   
 textF.addTarget(self, action: #selector(textChanged), for: UIControl.Event.editingChanged)
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

// axe after the callback and new data is loaded from a server call???, this lets us update the displayed list
public func updateList(list: [AutoFillTextFieldData])
{
 Queues.dispatchMainQueueAsync    // axe we have to make sure this is on main Q so table does not get corrupted
   { [weak self] in
   self?.setupLists(list: list)
   self?.filteredList.removeAll()
   self?.filteredList.append(contentsOf: self?.list ?? [])
   self?.tableV?.reloadData()
   }
}


private func trigger() -> Bool
{
 if let chr = textF?.text?.last  // axe triggers are checked on each keystroke entered and must be preceded by a space or be first in textfield
    {
    if triggers.contains(String(chr))
       {
       if textF?.text?.count == 1 { return true }

       guard let txt = textF?.text else { return false }        
       if String(txt[txt.index(txt.endIndex, offsetBy: -2)...]) == " \(chr)" { return true }  // since it's past 1st pos make sure it has a space before it
       }
    }  
    
 return false    
}


private func checkCancelable()   // axe I truly love this guy
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
 
 if trigger() { lookupOff() }  // axe if another trigger presents then shut off previous trigger so a new oone can be initiated 
 
 if inLookupMode    // axe table is displayed
    {
    guard let txt = textF?.text else 
      {
      lookupOff() 
      return 
      }
      
    if indexOfTrigger < txt.count  // axe make sure they do not back over trigger
       {
       let subS = String(txt[txt.index(txt.endIndex, offsetBy: -(txt.count - indexOfTrigger - 1))...]) // axe remove trigger char
       filteredList = list.filter({ (item) -> Bool in return item.name.hasPrefix(subS) })  // axe match what they typed

       tableV?.isHidden = filteredList.count < 1  // axe no matches                       
       tableV?.reloadData()
       }
    else
       {
       lookupOff()
       }   
    }   

 if trigger() && inLookupMode == false
    {
    if let text = textF?.text { indexOfTrigger = text.count - 1 }
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
 tableV.scrollsToTop = true
 tableV.setContentOffset(CGPoint.zero, animated: false)
 
 inLookupMode = true
}


public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
{
 return filteredList.count
}


private func checkCache(url: URL) -> Int?
{
 return imageList.index(where: 
          { (item) -> Bool in
          return item.imageUrl == url.absoluteString
          })
}


public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
{
 let cell = tableView.dequeueReusableCell(withIdentifier: "axeCell", for: indexPath)
         
 cell.imageView?.image     = nil  // axe initialize cell
 cell.backgroundColor      = self.backColor
 cell.textLabel?.textColor = self.textColor
 cell.tag = cellTagID
 cellTagID += 1

 cell.textLabel?.text = filteredList[indexPath.row].name

 if filteredList[indexPath.row].imageUrl.count > 0, let url = URL(string: filteredList[indexPath.row].imageUrl)
    {
    if let index = checkCache(url: url)
       {
       cell.imageView?.image = imageList[index].image
       }
    else   
       {
       cell.imageView?.image = UIImage(named: "placeholder")  // axe place holder image
       Queues.dispatchBackgroundQueueASync 
         { [weak self] in
         let tagID = cell.tag

         if let data = try? Data(contentsOf: url) 
            {
            if let image = UIImage(data: data)
               {
               self?.imageList.append(AutoFillTextFieldData(name: "", imageUrl: url.absoluteString, image: image))

               Queues.dispatchMainQueueAsync
                 {  
                 if cell.tag == tagID { cell.imageView?.image = image } // axe prevents writing on a resused cell
                 }
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
 
 textF?.removeTarget(self, action: #selector(textChanged), for: UIControl.Event.editingChanged)
 textF  = nil
 view   = nil    
 list.removeAll()
 imageList.removeAll()
}


deinit
{
 close()
}


}
