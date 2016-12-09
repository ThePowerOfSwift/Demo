//
//  ToolRowAccessoryTopView.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 10/25/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class ToolRowAccessoryTopView: ToolRow
{
    @IBInspectable @IBOutlet weak var sliderAnimationPower: UISlider!
    @IBInspectable @IBOutlet weak var labelAnimationPower:UILabel!
    
    override func refreshUI() {
        super.refreshUI()
        UIUpdatePower()
        UIUpdatePowerText()
    }
    
    func UIUpdateHistory() {
        UIUpdatePower()
        UIUpdatePowerText()
    }
    
    @IBAction func slideAnimationPower(sender: UISlider) {
        if sender === sliderAnimationPower {
            if let engine = ApplicationController.shared.engine {
                engine.animationPower = CGFloat(sliderAnimationPower.value)
                UIUpdatePowerText()
            }
        }
    }
    
    func UIUpdatePower() {
        if let engine = ApplicationController.shared.engine {
            sliderAnimationPower.value = Float(engine.animationPower)
        }
    }
    
    func UIUpdatePowerText() {
        if let engine = ApplicationController.shared.engine {
            let percentInt = Int(Float(engine.animationPower * 100.0 + 0.5))
            labelAnimationPower.text = "\(percentInt)%"
        }
    }
    
    override func handleSceneReady() {
        super.handleSceneReady()
        
    }
    
    func handleHistoryChanged() {
        UIUpdateHistory()
    }
}


