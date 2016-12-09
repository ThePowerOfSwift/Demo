//
//  ToolRowTopView.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 10/25/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class ToolRowTopView: ToolRow
{
    @IBInspectable @IBOutlet weak var sliderAnimationPower: UISlider!
    @IBInspectable @IBOutlet weak var labelAnimationPower:UILabel!
    
    @IBInspectable @IBOutlet weak var sliderAnimationSpeed: UISlider!
    @IBInspectable @IBOutlet weak var labelAnimationSpeed:UILabel!
    
    override func refreshUI() {
        super.refreshUI()
        UIUpdatePower()
        UIUpdateSpeed()
        UIUpdatePowerText()
        UIUpdateSpeedText()
    }
    
    func UIUpdateHistory() {
        UIUpdatePower()
        UIUpdateSpeed()
        UIUpdatePowerText()
        UIUpdateSpeedText()
    }
    
    @IBAction func slideAnimationPower(sender: UISlider) {
        if sender === sliderAnimationPower {
            if let engine = ApplicationController.shared.engine {
                engine.animationPower = CGFloat(sliderAnimationPower.value)
                UIUpdatePowerText()
            }
        }
    }
    
    @IBAction func slideAnimationSpeed(sender: UISlider) {
        if sender === sliderAnimationSpeed {
            if let engine = ApplicationController.shared.engine {
                engine.animationSpeed = CGFloat(sliderAnimationSpeed.value)
                UIUpdateSpeedText()
            }
        }
    }
    
    func UIUpdatePower() {
        if let engine = ApplicationController.shared.engine {
            sliderAnimationPower.value = Float(engine.animationPower)
        }
    }
    
    func UIUpdateSpeed() {
        if let engine = ApplicationController.shared.engine {
            sliderAnimationSpeed.value = Float(engine.animationSpeed)
        }
    }
    
    func UIUpdatePowerText() {
        if let engine = ApplicationController.shared.engine {
            let percentInt = Int(Float(engine.animationPower * 100.0 + 0.5))
            labelAnimationPower.text = "\(percentInt)%"
        }
    }
    
    func UIUpdateSpeedText() {
        if let engine = ApplicationController.shared.engine {
            let percentInt = Int(Float(engine.animationSpeed * 100.0 + 0.5))
            labelAnimationSpeed.text = "\(percentInt)%"
        }
    }
    
    override func handleSceneReady() {
        super.handleSceneReady()
        
    }
    
    func handleHistoryChanged() {
        UIUpdateHistory()
    }
}


