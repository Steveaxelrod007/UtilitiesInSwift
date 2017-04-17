// axee.com by Steve Axelrod

import UIKit
import Foundation

@IBDesignable class UIViewDesignable: UIView
{

@IBInspectable var borderWidth: CGFloat = 0.0
{
 didSet
 {
 layer.borderWidth = borderWidth
 }
}


@IBInspectable var borderColor: UIColor = UIColor.clear 
{
 didSet 
 {
 layer.borderColor = borderColor.cgColor
 }
}


override func prepareForInterfaceBuilder() 
{
 super.prepareForInterfaceBuilder()
}
}
