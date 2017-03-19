// axee.com by Steve Axelrod

import Foundation
import UIKit


public class AutoFillTextField
{
var triggers = ""
var textF = UITextField()


public init(triggers: String, textF: UITextField)
{
 self.triggers = triggers
 self.textF = textF

 textF.addTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged) 
}


@objc func textChanged()
{

}


}
