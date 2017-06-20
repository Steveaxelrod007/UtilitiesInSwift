// axee.com by Steve Axelrod

import UIKit
import Foundation

@IBDesignable class UIDesignableButton: UIButton
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


@IBInspectable var radius: CGFloat = 0.0
{
 didSet
 {
 layer.cornerRadius = radius
 layer.masksToBounds = true
 }
} 


override func prepareForInterfaceBuilder() 
{
 super.prepareForInterfaceBuilder()
}


}

