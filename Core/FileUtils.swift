//
//  FileUtils.swift
//
//  Created by Nicholas Raptis on 9/23/15.
//

import UIKit

open class FileUtils
{
    open class var bundleDir: String {
        var result:String! = nil
        result = Bundle.main.resourcePath
        result = result + "/"
        return result
    }
    
    open class var docsDir: String {
        var result:String! = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        result = result + "/"
        return result
    }
    
    open class func getDocsPath(filePath:String?) -> String {
        var result = FileUtils.docsDir
        if let path = filePath { result = result + path }
        return result
    }
    
    open class func getBundlePath(filePath:String?) -> String {
        var result = FileUtils.bundleDir
        if let path = filePath { result = result + path }
        return result
    }
    
    open class func findAbsolutePath(filePath:String?) -> String? {
        if let path = filePath , path.characters.count > 0 {
            if fileExists(filePath: path) {
                return path
            }
            let bundlePath = FileUtils.getBundlePath(filePath: path)
            if fileExists(filePath: bundlePath) {
                return bundlePath
            }
            let docsPath = FileUtils.getDocsPath(filePath: path)
            if fileExists(filePath: docsPath) {
                return docsPath
            }
        }
        return nil
    }
    
    class func fileExists(filePath:String?) -> Bool {
        if let path = filePath , path.characters.count > 0 {
            return FileManager.default.fileExists(atPath: path)
        }
        return false
    }
    
    open class func saveData(data:inout Data?, filePath:String?) -> Bool {
        if let path = filePath, data != nil {
            do {
                try data!.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
                return true
            } catch {
                print("Unable to save Data [\(filePath)]")
            }
        }
        return false
    }
    
    open class func loadData(_ filePath:String?) -> Data? {
        if let path = FileUtils.findAbsolutePath(filePath: filePath) {
            return (try? Data(contentsOf: URL(fileURLWithPath: path)))
        }
        return nil
    }
    
    open class func deleteFile(_ filePath:String?) -> Void {
        
        print("Deleting File [\(filePath)]")
        
        if let path = FileUtils.findAbsolutePath(filePath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                print("Unable to delete Data [\(filePath)]")
            }
        }
    }
    
    open class func copyFile(from filePath1: String?, to filePath2: String?) -> Void {
        print("Copying File\n[\(filePath1!)]\nto\n[\(filePath2!)]")
        if let path1 = filePath1, let path2 = filePath2 {
            if path1 != path2 {
                do {
                    try FileManager.default.copyItem(atPath: path1, toPath: path2)
                } catch {
                    print("Unable to copy file [\(path1)] to [\(path2)]")
                }
            }
        }
    }
    
    //Eventually we'll be wanting to bundle these images togther.
    open class func loadImage(_ filePath:String?) -> UIImage? {
        var image: UIImage?
        if let path = filePath {
            image = UIImage(named: path)
            
            if image == nil {
                
                //jpg, png, jpeg, JPG, PNG, JPEG, gif, GIF
                
            }
            
        }
        return image
    }
    
    open class func saveImagePNG(image:UIImage?, filePath:String?) -> Bool {
        if image != nil {
            var imageData = UIImagePNGRepresentation(image!)
            if FileUtils.saveData(data: &imageData, filePath: filePath) {
                return true
            } else {
                print("Unable to save image (\(image!.size.width)x\(image!.size.height)) [\(filePath)]")
            }
        }
        return false
    }
    
    class func parseJSON(data: Data?) -> Any? {
        var result:Any?
        if(data != nil) {
            do {
                result = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
            } catch {
                print("JSON Serialization Failed")
            }
        }
        return result
    }
}


