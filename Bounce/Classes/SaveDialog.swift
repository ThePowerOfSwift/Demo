//
//  SaveDialog.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/23/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class SaveDialog: UIView, UITextFieldDelegate, TBCheckBoxDelegate {

    //@IBOutlet
    
    
    //
    
    weak var saveDialogViewController: SaveDialogViewController!
    
    
    func setUp() {
        
        if let engine = ApplicationController.shared.engine {
            
            let currentDate = Date()
            //let components = NSCalendar.current.components([.day, .month, .year], fromDate: currentDate)
            
            let components = NSCalendar.current.dateComponents([.day, .month, .year], from: currentDate)
            let day:Int = (components.day != nil) ? components.day! : 0
            let month:Int = (components.month != nil) ? components.month! : 0
            let year = (components.year != nil) ? components.year! : 0
            
            var yearString = "\(year)"
            while yearString.characters.count < 4 {
                yearString = "0".appending(yearString)
            }
            
            var monthString = "\(month)"
            while monthString.characters.count < 3 {
                monthString = "0".appending(monthString)
            }
            
            var dayString = "\(day)"
            while dayString.characters.count < 3 {
                dayString = "0".appending(dayString)
            }
            
            var nameString = "Bounce \(yearString)-\(monthString)-\(dayString)"
            
            textFieldName.text = nameString
        }
        
        
    }
    
    @IBOutlet weak var textFieldName: UITextField! {
        didSet {
            textFieldName.delegate = self
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
            
            setUp()
        }
    }
    
    @IBOutlet weak var checkBoxOverwrite: TBCheckBox! {
        didSet {
            checkBoxOverwrite.delegate = self
        }
    }
    
    @IBOutlet weak var buttonClear: UIButton!
    
    @IBOutlet weak var buttonOK: IconButton! {
        didSet {
            
            //buttonOK
            
            
            buttonOK.setImages(path: "tb_btn_undo", pathSelected: "tb_btn_undo_down")
            
        }
    }
    
    deinit {
        print("DEINIT - SaveDialog")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    @IBAction func clickOK(_ sender: IconButton) {
        print("clickOK")
        
        if saveDialogViewController.locked { return }
        
        if let bounce = ApplicationController.shared.bounce {
            bounce.saveScene(filePath: "\(textFieldName.text!).json")
        }
        
    }
    
    @IBAction func clickClear(_ sender: UIButton) {
        print("clickClear")
        
        if saveDialogViewController.locked { return }
        
        textFieldName.text = ""
        if !textFieldName.isFirstResponder {
            textFieldName.becomeFirstResponder()
        }
    }
    
    func handleTextChange() -> Void {
        print("Text = \(textFieldName.text)")
        
        if saveDialogViewController.locked { return }
        
        
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    // called when clear button pressed. return NO to ignore (no notifications)
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    // called when 'return' key pressed. return NO to ignore.
    
    func checkBoxToggled(checkBox:TBCheckBox, checked: Bool) {
        
    }
    
    
}
