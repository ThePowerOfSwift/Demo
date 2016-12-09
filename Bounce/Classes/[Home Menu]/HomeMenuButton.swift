//
//  HomeMenuButton.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/17/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//


import UIKit

class HomeMenuButton: UIButton {
    
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                image = UIImage(named: path)
            }
        }
    }
    
    var image: UIImage?
    
    deinit {
        print("HomeMenuButton deinit..")
    }
    
    
    //internal var _isEnabled = false
    override var isEnabled: Bool {
        set {
            super.isEnabled = newValue
            setNeedsDisplay()
        }
        get {
            return super.isEnabled
        }
    }
    
    var fill:Bool = true { didSet { setNeedsDisplay() } }
    var fillDown:Bool = true { didSet { setNeedsDisplay() } }
    
    var fillColor:UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) { didSet { setNeedsDisplay() } }
    var fillColorDown:UIColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0) { didSet { setNeedsDisplay() } }
    
    var cornerRadius:CGFloat = 6.0 { didSet { setNeedsDisplay() } }
    
    private var _highlightAlpha: CGFloat = 0.0
    var highlightAlpha: CGFloat {
        set {
            if newValue != _highlightAlpha {
                _highlightAlpha = newValue
                setNeedsDisplay()
            }
        }
        get {
            return _highlightAlpha
        }
    }
    
    var isPressed:Bool {
        return isTouchInside && isTracking
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        cornerRadius = ApplicationController.shared.tbButtonHeight / 7.0
        
        self.backgroundColor = UIColor.clear
        
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchDown)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchDragInside)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchDragOutside)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchCancel)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchUpInside)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchUpOutside)
        self.addTarget(self, action: #selector(didClick), for: .touchUpInside)
        
        
        //layer.cornerRadius = 20
        layer.shadowColor = UIColor(red: 0.03, green: 0.03, blue: 0.03, alpha: 0.36).cgColor
        layer.shadowOffset = CGSize(width:-3.0, height: 1.5) //Here your control your spread
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 3.0
        
        
        //Back: 960 x 280 -> 480 x 140 -> 240 x 70
        
    }
    
    func getCornerType() -> UIRectCorner {
        return .allCorners
    }
    
    func update() -> Void {
        
        if isPressed {
            if highlightAlpha < 1.0 {
                highlightAlpha += 0.14
                if highlightAlpha > 1.0 { highlightAlpha = 1.0 }
            }
            
        } else {
            if highlightAlpha > 0.0 {
                highlightAlpha -= 0.14
                if highlightAlpha < 0.0 { highlightAlpha = 0.0 }
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        //super.draw(rect)
        
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        let rect = bounds
        
        let clipPath = UIBezierPath(roundedRect: rect,
         byRoundingCorners: getCornerType(),
         cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        context.beginPath()
        context.addPath(clipPath)
        context.setFillColor(isPressed ? fillColorDown.cgColor : fillColor.cgColor)
        context.closePath()
        context.fillPath()
        
        drawImage()
        
        if highlightAlpha > 0.0 {
            let highlightColor = UIColor(red: 0.2, green: 0.2, blue: 0.25, alpha: highlightAlpha * 0.34)
            context.beginPath()
            context.addPath(clipPath)
            context.setFillColor(highlightColor.cgColor)
            context.closePath()
            context.fillPath()
        }
        
        context.restoreGState()
    }
    
    func drawImage() {
        
        let rect = bounds
        
        if let img = image {
            var imageAlpha: CGFloat = 1.0
            if isEnabled == false { imageAlpha = 0.5 }
            let imgRect = CGRect(x: width / 2.0 - img.size.width / 2.0, y: height / 2.0 - img.size.height / 2.0, width: img.size.width, height: img.size.height)
            img.draw(in: imgRect, blendMode: .normal, alpha: imageAlpha)
        }
    }
    
    func didToggleControlState() {
        self.setNeedsDisplay()
    }
    
    func didClick() {
        
    }
}
