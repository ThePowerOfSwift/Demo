//
//  HomeMenuMainContent.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/17/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class HomeMenuMainButtons: UIView {

    weak var homeMenu: HomeMenuViewController?
    
    @IBOutlet weak var newButtonWidthConstraint: NSLayoutConstraint! {
        didSet {
            if Device.isTablet {
                newButtonWidthConstraint.constant = 360
                setNeedsUpdateConstraints()
            }
        }
    }
    
    @IBOutlet weak var newButtonHeightConstraint: NSLayoutConstraint! {
        didSet {
            if Device.isTablet {
                newButtonHeightConstraint.constant = 105
                setNeedsUpdateConstraints()
            }
        }
    }
    
    @IBOutlet weak var buttonNew: HomeMenuLargeButton! {
        didSet {
            buttonNew.imagePath = "hm_button_new_scene"
            buttonNew.imageIconPath = "hm_icon_new_scene"
        }
    }
    
    @IBOutlet weak var buttonWeb: HomeMenuLargeButton! {
        didSet {
            buttonWeb.imagePath = "hm_button_web"
            buttonWeb.imageIconPath = "hm_icon_web"
        }
    }
    
    @IBOutlet weak var buttonContinueLast: HomeMenuButton! {
        didSet {
            buttonContinueLast.imagePath = "hm_button_new_scene"
        }
    }
    
    @IBOutlet weak var buttonLoad: HomeMenuButton! {
        didSet {
            buttonLoad.imagePath = "hm_button_new_scene"
        }
    }
    
    @IBOutlet weak var buttonCloud: HomeMenuButton! {
        didSet {
            buttonCloud.imagePath = "hm_button_new_scene"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    deinit {
        print("Main Content deinit..")
        
    }
    
    func setUp() {
        clipsToBounds = false
        isMultipleTouchEnabled = false
        backgroundColor = UIColor.clear
    }
    
    func update() {
        buttonNew.update()
        buttonWeb.update()
        
        buttonLoad.update()
        buttonCloud.update()
        buttonContinueLast.update()
    }
    
    @IBAction func clickNew(_ sender: HomeMenuButton) {
        homeMenu?.clickNew()
    }
    
    @IBAction func clickWeb(_ sender: HomeMenuButton) {
        //showImagePicker(sender)
        homeMenu?.clickWeb()
    }
    
    @IBAction func clickContinueLast(_ sender: HomeMenuButton) {
        homeMenu?.clickContinueLast()
    }
    
    @IBAction func clickLoad(_ sender: HomeMenuButton) {
        homeMenu?.clickLoad()
    }
    
    @IBAction func clickCloud(_ sender: HomeMenuButton) {
        //homeMenu?.clickWeb()
    }
    
}
