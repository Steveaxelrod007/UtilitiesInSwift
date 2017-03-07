// axee.com by Steve Axelrod

import Foundation

public class CancelableClosure 
{
public var cancelled = false
public var closure: () -> () = {}
    
    
public func run() 
{
 if cancelled == false 
    {
    cancelled = true  // axe in case they also did a runAfterDelayOf
    closure()
    }
}


public func runAfterDelayOf(delayTime: Double = 0.5) 
{
 if cancelled == false 
    {
    Queues.delayThenRunMainQueue(delay: delayTime)
      { [weak self] () -> Void in
      if self?.cancelled == false
         {
         self?.run()
         }
      }
    }
}


public init()
{
}


}
