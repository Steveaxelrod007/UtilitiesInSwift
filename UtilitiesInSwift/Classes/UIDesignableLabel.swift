// axee.com by Steve Axelrod

import UIKit
import Foundation

@IBDesignable class UIDesignableLabel: UILabel
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


@IBInspectable var topInset:    CGFloat = 0

@IBInspectable var bottomInset: CGFloat = 0

@IBInspectable var leftInset:   CGFloat = 0

@IBInspectable var rightInset:  CGFloat = 0


override func drawText(in rect: CGRect) 
{
 let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
 super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
}


override var intrinsicContentSize: CGSize 
{
 get 
 {
 var contentSize = super.intrinsicContentSize
 contentSize.height += (topInset  + bottomInset)
 contentSize.width  += (leftInset + rightInset)
 
 return contentSize
 }
}


override func prepareForInterfaceBuilder() 
{
 super.prepareForInterfaceBuilder()
}


}

