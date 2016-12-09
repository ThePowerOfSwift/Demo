//
//  SideMenu.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/2/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class BounceSideMenu: UIView {
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonPublish:SideMenuButton! {
        didSet {
            buttonPublish.imageIconPath = "sm_btn_icon_publish"
            buttonPublish.imagePath = "sm_btn_text_save"
            
            
            //sm_btn_icon_save
            //sm_btn_icon_publish
            //sm_btn_text_save
            
        }
    }
    @IBOutlet weak var buttonSave:SideMenuButton!
    @IBOutlet weak var buttonClear:SideMenuButton!
    @IBOutlet weak var buttonExit:SideMenuButton!
    
    func setUp() {
        
    }
    
    func update() {
        
    }
    
    @IBAction func clickExit(sender: AnyObject) {
        ToolActions.navigateHome()
        
    }
    
    @IBAction func clickPublish(sender: AnyObject) {
        ToolActions.new()
    }
    
    @IBAction func clickSave(sender: AnyObject) {
        ToolActions.save()
    }
    
    @IBAction func clickClear(sender: AnyObject) {
        //ToolActions.
        
    }
    
}
