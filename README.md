# UtilitiesInSwift

[![CI Status](http://img.shields.io/travis/steveaxelrod007/UtilitiesInSwift.svg?style=flat)](https://travis-ci.org/steveaxelrod007/UtilitiesInSwift)
[![Version](https://img.shields.io/cocoapods/v/UtilitiesInSwift.svg?style=flat)](http://cocoapods.org/pods/UtilitiesInSwift)
[![License](https://img.shields.io/cocoapods/l/UtilitiesInSwift.svg?style=flat)](http://cocoapods.org/pods/UtilitiesInSwift)
[![Platform](https://img.shields.io/cocoapods/p/UtilitiesInSwift.svg?style=flat)](http://cocoapods.org/pods/UtilitiesInSwift)

## Example
Utility functions for swift that have been created through the years.  Some converted from other languages.  
The utilities are broken down by type categories (I did what I thought was ok).

Queues --> I mainly created these so as Swift morphs, I can easily adjust the function bodies and not all over the code base, plus, I may want to add later functionality.

NumbersToWords --> Converts a number String "$1,234.56" to "one thousand two hundred thirty four dollars and 56/100"

     let words = NumbersToWords.convert(amount: "1.31") 
     print(words)
     One Dollar and 31/100
      
     let words = NumbersToWords.convert(amount: "9,304.67") 
     print(words)
     nine thousand three hundred four dollars and 67/100
      
     amount can be 0.01 ... 999,999.99  nine hundred ninety nine thousand nine hundred ninety nine dollars and 99/100

SendLocalAlert --> A simple way to send and stop local alerts              

Phone --> See if device is currently on a phone call

FileSystem --> clear out temp files, determine available space on device             

CancelableClosure --> I use it for waiting for 0.5 seconds to elapse on key strokes, then call some lookup function

     var cc = CancelableClosure()       // axe maintain the var
       
     cc.cancelled = true                // axe stop current one from running
            
     let newCc = CancelableClosure()    // axe create new one inside your acceptance of keystrokes func 
     newCc.closure =
       {// [weak self] in
       // axe this is where you would make a server call to fetch a new search lookup based on keystrokes or something
       }
    
     cc = newCc                         // axe set to global var 
     cc.runAfterDelayOf(delayTime: 0.5) // axe if nothing happens (i.e. user stops typing) then closure is called
       
UIColor Extension --> great way to save a color value as an Int then pull from database and easily convert back to UIColor                   

     let color = UIColor.init(red: 10, green: 20, blue: 30)   // axe easy way to create a color
     let colorInt = UIColor.hexFromColor(color: color)        // axe converts to an Int value for easy saving
     UIColor.colorWithHex(hex: colorInt)                      // axe convert saved Int back to a color
     // axe it is called hex as lots of folks express colors as hex values 0xFF1020 as an example
     // colorWithHex  takes an Int that can be a hex value as well, in the end it's all 0 and 1's

Int Extension --> convert Int to String distance, format Ints with commas, convert to thousands(k) and millions(m)
 
     intVal = 123
     intVal.distance()     --> 123ft
     intVal.fullNotation() --> 123
     intVal.kmNotation()   --> 123
    
     intVal = 4567
     intVal.distance()     --> 0.86mi
     intVal.fullNotation() --> 4,567
     intVal.kmNotation()   --> 4.6k
    
     intVal = 5280000
     intVal.distance()     --> 1,000mi
     intVal.fullNotation() --> 5,280,000
     intVal.kmNotation()   --> 5.28m
 
AutoFillTextField --> if trigger char is matched while typing in textfield a popup selection list is displayed.  A nice way to select an item from a table.
     
     var autoComplete:AutoFillTextField?

     
     let listOfNames = [
                       AutoFillTextFieldData(name: <This is displayed and returned>, imageUrl: <link to image if availble>),
                       ]
   
     autoComplete = AutoFillTextField(triggers: "@+*", textF: textF, view: view, list: listOfNames, backColor: UIColor.brown, textColor: UIColor.red)
 
     AutoFillTextField
       (
       triggers: <characters that activate the table view popup>, 
       textF: UITextField,                                              // axe weak referenced 
       view: <the view the textfield is in>,                            // axe weak referenced 
       list: <AutoFillTextFieldData array of items to display>,
       tableView: <optional or pass in your own table that I use>, 
       backColor: <optional background color of table>, 
       textColor: <optional color of text>
       ) 

     
  


## Requirements

## Installation

UtilitiesInSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UtilitiesInSwift"
```

## Author

steveaxelrod007, steve@axelrod.net

## License

UtilitiesInSwift is available under the MIT license. See the LICENSE file for more info.
