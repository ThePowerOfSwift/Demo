//
//  FileList.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 12/8/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class SavedFileList : NSObject {
    
    //In-Order list of file names..
    var                         nameList = [String]()
    var                         nameDic = [String:String]()
    
    
    func fileExists(filePath: String?) -> Bool {
        if let path = filePath {
            let result = nameDic[path]
            if result != nil { return true }
        }
        return false
    }
    
    func addFile(filePath: String?) -> Void {
        if let path = filePath {
            
            if fileExists(filePath: path) == false {
                
                nameList.append(path)
                nameDic[path] = "A"
                
                save()
            }
        }
    }
    
    func removeFile(filePath: String?) -> Void {
        
    }
    
    func load() {
        
    }
    
    func save() {
        
        var savePath = FileUtils.getDocsPath(filePath: "saved_file_list.json")
        
        
        
        
    }
    
}
