// axee.com by Steve Axelrod

import Foundation

extension Int
{
public func kmNotation() -> String
{
 if self < 1000 { return String(self) }
 else
 if self < 1000000 
    {
    let str = "\(String(format: "%.1f", (Float(self) / 1000)))"
    
    if str == "1000.0" { return "1m" }  // axe special case, convert to m format
    
    return str.contains(".0") ? String(str[..<str.index(str.endIndex, offsetBy: -2)]) + "k" : str + "k"
    } 
 else
    {
    let str = "\(String(format: "%.2f", (Float(self) / 1000000)))"
      
    return str.contains(".00") ? String(str[..<str.index(str.endIndex, offsetBy: -3)]) + "m" : str + "m" 
    }
}
  
  
public func fullNotation() -> String
{
 let numberFormatter = NumberFormatter()
 numberFormatter.locale = NSLocale.current
 numberFormatter.numberStyle = .decimal
 numberFormatter.usesGroupingSeparator = true

 return numberFormatter.string(from: NSNumber(value: self)) ?? ""
}


public func distance(convertMeters: Bool? = false) -> String // axe if Int is in meters then set this so we convert it to feet
{
 let convertMeters = convertMeters ?? false
 
 let feet = (convertMeters) ?  (Double(self) * Double(3.28084)) : Double(self)  // axe convert from meters?

 if feet < 1000
    {
    return "\(Int(feet))ft"
    }
 else
 if feet < (10 * 5280) 
    {
    return "\(String(format: "%.2f", Float(feet / 5280.0)))mi"
    }
 else
    {
    let miles = feet / 5280.0
    
    if miles <= 999
       {
       return "\(String(format: "%.1f", Float(feet / 5280.0)))mi"
       }
    else
       {
       return "\(Int(miles).fullNotation())mi"
       }   
    }
}


}
