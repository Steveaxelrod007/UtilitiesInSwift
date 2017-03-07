// axee.com by Steve Axelrod

import Foundation

extension UIColor
{
public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat?=1.0)
{
 let newRed   = CGFloat(Double(red)   / 255.0)
 let newGreen = CGFloat(Double(green) / 255.0)
 let newBlue  = CGFloat(Double(blue)  / 255.0)
        
 self.init(red:newRed, green:newGreen, blue:newBlue, alpha:alpha ?? 1.0)
}


public class func colorWithHex(hex: Int, alpha: CGFloat?=1.0) -> UIColor 
{
 let red   = Int((hex >> 16) & 0xFF)
 let green = Int((hex >> 8) & 0xFF)
 let blue  = Int((hex) & 0xFF)

 return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}


public class func hexFromColor(color: UIColor) -> Int 
{
 guard let vals = color.cgColor.components else { return 0 }

 let red   = Int(Int(vals[0] * 255.0) & 0xFF)
 let green = Int(Int(vals[1] * 255.0) & 0xFF)
 let blue  = Int(Int(vals[2] * 255.0) & 0xFF)
 
 return red << 16 + green << 8 + blue 
}
}
