// axee.com by Steve Axelrod

import Foundation
import UIKit


extension UIViewController
{
class func makeMeFirst() -> UIViewController?
{
 if let window = UIApplication.shared.windows.first
    {
    window.rootViewController?.dismissPresentedViewControllers()

    let SB = UIStoryboard(name: String(describing: self), bundle: nil)
    
    window.rootViewController = SB.instantiateInitialViewController()
    
    return window.rootViewController
    }

 return nil    
}


func makeMeTop()
{
 if let window = UIApplication.shared.windows.first
    {
    window.rootViewController?.dismissPresentedViewControllers()

    window.rootViewController = self
    }
}


func dismissPresentedViewControllers()
{
 presentedViewController?.dismiss(animated: false)   // axe maintain strong ref in case there is more than one, it will return nill when they are all gone
   { 
   self.dismissPresentedViewControllers() 
   }
}


}

