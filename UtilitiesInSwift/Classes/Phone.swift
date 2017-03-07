// axee.com by Steve Axelrod

import Foundation
import CallKit


public class Phone
{

@available(iOS 10.0, *)
public class func onPhone() -> Bool
{
 for call in CXCallObserver().calls 
   {
   if call.hasEnded == false { return true }
   }

 return false
}

}
