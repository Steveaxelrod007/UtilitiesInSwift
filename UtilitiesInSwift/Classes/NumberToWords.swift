// axee.com by Steve Axelrod

import Foundation


public class NumberToWords
{


public class func convert(amount: String) -> String   // axe assumes 0.00 minimum amount sent in  for 50 cents  0.50
{
let oneToNineteen = ["", "one", "two", "three", "four", "five", "six",   // axe numbers we index with are one relative
                     "seven", "eight", "nine", "ten", "eleven", "twelve",
                     "thirteen", "fourteen", "fifteen", "sixteen", "seventeen",
                     "eighteen", "nineteen"]

let tens = ["", "", "twenty", "thirty", "fourty", "fifty", "sixty", "seventy", "eighty", "ninety"]
            
let defaultString = "****Zero Dollars and 00/100****"
var retCents   = " and 0/100"
var retDollars = ""

 let newAmount = amount.components(separatedBy: CharacterSet(charactersIn: "0123456789.").inverted).joined() // axe remove any commas, spaces.... 
 var values = newAmount.components(separatedBy: ".")  // axe convert to 1234.56 format

 guard let dollars = values.first else { return defaultString }  // axe check for some values
   
 values.removeFirst()   // axe see if there are any pennies to display
 if var cents = values.first
    {
    while cents.characters.count > 2 
       { 
       cents.characters = cents.characters.dropLast() 
       }
       
    retCents = " and " + cents + "/100"    
    }

 guard var dollarAmount = Int(dollars) else { return defaultString }
 
 if dollarAmount < 1  { return "****zero dollars" + retCents + "****" }
 if dollarAmount == 1 { return "****one dollar"   + retCents + "****"}
 
 while dollarAmount > 0
   {
   switch(dollarAmount)
      {
      case 1...19: 
           retDollars = retDollars + oneToNineteen[dollarAmount] + " dollars "
           dollarAmount -= dollarAmount

      case 20...99:
           let val = dollarAmount / 10   // axe get tens digit
           retDollars = retDollars + tens[val] + " "
           dollarAmount -= (val * 10)
           retDollars = retDollars + oneToNineteen[dollarAmount] + " dollars "
           dollarAmount -= dollarAmount
                   
      case 100...999: 
           let val = dollarAmount / 100  // axe get hundreds digit
           retDollars = retDollars + oneToNineteen[val] + " hundred "
           dollarAmount -= (val * 100)
           if dollarAmount == 0 { retDollars = retDollars + "dollars " }

      case 1000...9999: 
           let val = dollarAmount / 1000  // axe get thousands digit
           retDollars = retDollars + oneToNineteen[val] + " thousand "
           dollarAmount -= (val * 1000)
           if dollarAmount == 0 { retDollars = retDollars + "dollars " }

      case 10000...99999: 
           let val = dollarAmount / 1000  // axe get thousands digit
           
           if val < 20
              {
              retDollars = retDollars + oneToNineteen[val] + " thousand "
              }
           else
              {
              let tenVal = val / 10        // axe get tens digit
              retDollars = retDollars + tens[tenVal] + " "
              let singlesVal = val - (tenVal * 10)   // axe get singles digit
              retDollars = retDollars + oneToNineteen[singlesVal] + " thousand "
              }   

           dollarAmount -= (val * 1000)   // axe adjust dollar amount for loop
           if dollarAmount == 0 { retDollars = retDollars + "dollars " }

      case 100000...999999:
           let val = dollarAmount / 100000  // axe get hundred thousand digit
           retDollars = retDollars + oneToNineteen[val] + " hundred "
           dollarAmount -= (val * 100000)
           if dollarAmount == 0 { retDollars = retDollars + " thousand dollars " }
       
      default: break
      }
   }
 
 let combined = "****" + retDollars + retCents + "****"
  
 return combined.replacingOccurrences(of: "  ", with: " ")
}


}
