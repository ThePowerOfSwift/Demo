//
//  IconButton.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/30/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class IconButton: UIButton {
    
    //var fill =
    
    var maxHeight: CGFloat?
    
    var separatorWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
    
    var shapePoints = [CGPoint]()
    
    var image: UIImage? {
        if isPressed == true && isEnabled == true {
            if let img = imageDown {
                return img
            }
            if let img = imageUp {
                return img
            }
        } else {
            if let img = imageUp {
                return img
            }
            if let img = imageDown {
                return img
            }
        }
        return nil
    }
    
    func setImages(path: String?, pathSelected: String?) {
        if path != nil { imagePathUp = path! }
        if pathSelected != nil { imagePathDown = pathSelected! }
    }
    
    private var _imageUp:UIImage?
    var imageUp: UIImage? {
        if _imageUp == nil && imagePathUp != nil {
            _imageUp = FileUtils.loadImage(imagePathUp)
        }
        return _imageUp
    }
    
    private var _imageDown:UIImage?
    var imageDown: UIImage? {
        if _imageDown == nil && imagePathDown != nil {
            _imageDown = FileUtils.loadImage(imagePathDown)
        }
        return _imageDown
    }
    
    override var isEnabled: Bool {
        
        set {
            super.isEnabled = newValue
            setNeedsDisplay()
        }
        get {
            return super.isEnabled
        }
    }
    
    var fitImage: Bool = false { didSet { setNeedsDisplay() } }
    
    var imagePathUp: String? { didSet { setNeedsDisplay() } }
    var imagePathDown: String? { didSet { setNeedsDisplay() } }
    
    //var fill:Bool = true { didSet { setNeedsDisplay() } }
    //var fillDown:Bool = true { didSet { setNeedsDisplay() } }
    
    
    var fillColorLeft:UIColor = UIColor(red: 0.45, green: 0.45, blue: 1.0, alpha: 1.0) { didSet { setNeedsDisplay() } }
    var fillColorLeftDown:UIColor = UIColor(red: 0.65, green: 0.65, blue: 1.0, alpha: 1.0) { didSet { setNeedsDisplay() } }
    
    var fillColorRight:UIColor = UIColor(red: 0.25, green: 0.35, blue: 1.0, alpha: 1.0) { didSet { setNeedsDisplay() } }
    var fillColorRightDown:UIColor = UIColor(red: 0.25, green: 0.35, blue: 0.0, alpha: 1.0) { didSet { setNeedsDisplay() } }
    
    var fillColorSeparator:UIColor = UIColor(red: 0.65, green: 0.66, blue: 1.0, alpha: 1.0) { didSet { setNeedsDisplay() } }
    var fillColorSeparatorDown:UIColor = UIColor(red: 0.75, green: 0.90, blue: 1.0, alpha: 1.0) { didSet { setNeedsDisplay() } }
    
    
    var cornerRadius:CGFloat = 6.0 { didSet { setNeedsDisplay() } }
    
    var isPressed:Bool { return isTouchInside && isTracking }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    deinit {
        
    }
    
    func setUp() {
        cornerRadius = ApplicationController.shared.tbButtonHeight / 8.0
        
        if Device.isTablet { separatorWidth = 2.0 }
        
        self.backgroundColor = UIColor.clear
        
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchDown)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchDragInside)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchDragOutside)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchCancel)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchUpInside)
        self.addTarget(self, action: #selector(didToggleControlState), for: .touchUpOutside)
        self.addTarget(self, action: #selector(didClick), for: .touchUpInside)
        
        
        shapePoints.append(CGPoint(x:0.41, y: 0.54))
        shapePoints.append(CGPoint(x:0.43, y: 0.54))
        shapePoints.append(CGPoint(x:0.72, y: 0.25))
        shapePoints.append(CGPoint(x:0.75, y: 0.25))
        shapePoints.append(CGPoint(x:0.86, y: 0.36))
        shapePoints.append(CGPoint(x:0.86, y: 0.39))
        shapePoints.append(CGPoint(x:0.44, y: 0.81))
        shapePoints.append(CGPoint(x:0.40, y: 0.81))
        shapePoints.append(CGPoint(x:0.13, y: 0.54))
        shapePoints.append(CGPoint(x:0.13, y: 0.51))
        shapePoints.append(CGPoint(x:0.24, y: 0.40))
        shapePoints.append(CGPoint(x:0.27, y: 0.40))
        
        
    }
    
    func getCornerTypeLeft() -> UIRectCorner {
        var result:UIRectCorner = UIRectCorner(rawValue: 0)
        result = result.union(UIRectCorner.topLeft)
        result = result.union(UIRectCorner.bottomLeft)
        return result;
    }
    
    func getCornerTypeRight() -> UIRectCorner {
        var result:UIRectCorner = UIRectCorner(rawValue: 0)
        result = result.union(UIRectCorner.topRight)
        result = result.union(UIRectCorner.bottomRight)
        return result;
    }
    
    var drawRect: CGRect {
        var rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(Int(width + 0.5)), height: CGFloat(Int(height + 0.5)))
        if let max = maxHeight, rect.height > max {
            rect.size.height = max
            rect.origin.y = CGFloat(Int(self.height / 2.0 - max / 2.0))
        }
        return rect
    }
    
    override func draw(_ rect: CGRect) {
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        let frameRect = drawRect
        
        let rightWidth: CGFloat = frameRect.height
        let middleWidth: CGFloat = separatorWidth
        let leftWidth: CGFloat = frameRect.width - (rightWidth + middleWidth)
        
        let middleX: CGFloat = leftWidth
        let rightX: CGFloat = middleX + middleWidth
        
        
        
        
        if leftWidth > 0.0 {
            let rect = CGRect(x: 0.0, y: frameRect.origin.y, width: leftWidth, height: frameRect.height)
            let clipPath = UIBezierPath(roundedRect: rect,
                                        byRoundingCorners: getCornerTypeLeft(),
                                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            context.beginPath()
            context.addPath(clipPath)
            context.setFillColor(isPressed ? fillColorLeftDown.cgColor : fillColorLeft.cgColor)
            context.closePath()
            context.fillPath()
            
            if let img = image {
                var imageAlpha: CGFloat = 1.0
                if isEnabled == false { imageAlpha = 0.5 }

                    let imgRect = CGRect(x: rect.origin.x + rect.size.width / 2.0 - img.size.width / 2.0, y: rect.origin.y + rect.size.height / 2.0 - img.size.height / 2.0, width: img.size.width, height: img.size.height)
                    img.draw(in: imgRect, blendMode: .normal, alpha: imageAlpha)
                
            }
            
            
        }
        
        if middleWidth > 0.0 {
            let rect = CGRect(x: middleX, y: frameRect.origin.y, width: middleWidth, height: frameRect.height)
            context.setFillColor(isPressed ? fillColorSeparatorDown.cgColor : fillColorSeparator.cgColor)
            context.fill(rect)
        }
        
        if rightWidth > 0.0 {
            let rect = CGRect(x: rightX, y: frameRect.origin.y, width: rightWidth, height: frameRect.height)
            let clipPath = UIBezierPath(roundedRect: rect,
                                        byRoundingCorners: getCornerTypeRight(),
                                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            context.beginPath()
            context.addPath(clipPath)
            context.setFillColor(isPressed ? fillColorRightDown.cgColor : fillColorRight.cgColor)
            context.closePath()
            context.fillPath()
            
            if shapePoints.count > 0 {
                context.saveGState()
                let path = UIBezierPath()
                for i in 0..<shapePoints.count {
                    var point = shapePoints[i]
                    point.x = rect.origin.x + rect.size.width * (point.x)
                    point.y = rect.origin.y + rect.size.height * (point.y)
                    if i == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }
                let shadowColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 0.32)
                let shadowBlur:CGFloat = Device.isTablet ? 2.0 : 1.0
                context.beginPath()
                context.addPath(path.cgPath)
                context.closePath()
                context.setFillColor(UIColor.white.cgColor)
                context.setShadow(offset: CGSize(width: -1, height: 2), blur: shadowBlur, color: shadowColor.cgColor)
                context.fillPath()
                context.restoreGState()
            }
        }
        
        
        
        
        drawImage()
        
        context.restoreGState()
    }
    
    func drawImage() {
        
        let rect = drawRect
        
        if let img = image {
            var imageAlpha: CGFloat = 1.0
            if isEnabled == false { imageAlpha = 0.5 }
            
            if fitImage {
                let fit = CGSize(width: rect.size.width, height: rect.size.height).getAspectFit(img.size)
                let size = fit.size
                let imgRect = CGRect(x: width / 2.0 - size.width / 2.0, y: height / 2.0 - size.height / 2.0, width: size.width, height: size.height)
                img.draw(in: imgRect, blendMode: .normal, alpha: imageAlpha)
            } else {
                let imgRect = CGRect(x: width / 2.0 - img.size.width / 2.0, y: height / 2.0 - img.size.height / 2.0, width: img.size.width, height: img.size.height)
                img.draw(in: imgRect, blendMode: .normal, alpha: imageAlpha)
            }
        }
        
    }
    
    func didToggleControlState() {
        self.setNeedsDisplay()
    }
    
    func didClick() {
        
    }
    
}
