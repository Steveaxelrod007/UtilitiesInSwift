// axee.com by Steve Axelrod

import Foundation


public class FileSystem
{

public class func availableDeviceSpace() -> NSNumber
{
 do 
  {
  let dict = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
  if let freespace = dict[FileAttributeKey.systemFreeSize] as? NSNumber
     {
     return freespace
     }
  } 
 catch 
   {
   }
   
 return 0   
}


public class func removeALLfilesInTempDirectory()
{
 Queues.dispatchBackgroundQueueASync
   {
   do 
    {
    let tmpDirectory = try FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
    try tmpDirectory.forEach 
        { file in
        let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
        try FileManager.default.removeItem(atPath: path)
        }
    } 
   catch 
     {
     print("Error occured while attempting to remove files from temp directory --> \(error)")
     }
   }
}


}
