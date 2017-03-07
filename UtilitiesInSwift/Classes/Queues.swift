// axee.com by Steve Axelrod

import Foundation

// axe, I mainly created these so as Swift morphs, I can easily adjust the function bodies and not all over the code base

public class Queues  // axe cause it's funny
{

public class func dispatchMainQueueAsync(closure:@escaping ()->())
{
 DispatchQueue.main.async 
   {
   closure()
   } 
}


public class func dispatchMainQueueSync(closure:@escaping ()->())
{
 DispatchQueue.main.sync 
   {
   closure()
   } 
}


public class func dispatchBackgroundQueueSync(closure:@escaping ()->())
{
 DispatchQueue.global(qos: DispatchQoS.QoSClass.default).sync 
   {
   closure()
   } 
}


public class func dispatchBackgroundQueueASync(closure:@escaping ()->())
{
 DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async 
   {
   closure()
   } 
}


public class func delayThenRunMainQueue(delay:Double, closure:@escaping ()->())
{
 DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay)
   {
   closure()
   }
}


}
