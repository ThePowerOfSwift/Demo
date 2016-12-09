//
//  HomeMenuLetter.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/14/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class HomeMenuLetter: UIView {
    
    var dampen: CGFloat = 0.5
    
    var offset = CGPoint.zero
    var speed = CGPoint.zero
    
    
    deinit {
        print("Letter deinit..")
        
    }
    
    var image: UIImage!
    var imageView = UIImageView(frame: CGRect.zero) {
        didSet {
            backgroundColor = UIColor.lightText
        }
    }
    
    func setUp(withImage letterImage: UIImage) -> Void {
        image = letterImage
        addSubview(imageView)
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: image.size.width, height: image.size.height)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        imageView.image = image
    }
    
    func update(withGyroDir gyroDir: CGPoint, withBoundingBox boundingBox: CGRect) {
        
        var speedFactor: CGFloat = 0.2 - dampen * 0.004
        if Device.isTablet {
            speedFactor = 0.25 - dampen * 0.006
        }
        
        var diffX = -offset.x
        var diffY = -offset.y
        
        var dist = diffX * diffX + diffY * diffY
        
        if dist > Math.epsilon {
            dist = CGFloat(sqrtf(Float(dist)))
            diffX /= dist
            diffY /= dist
        } else {
            diffX = 0.0
            diffY = 0.0
        }
        
        speed.x += diffX * dist * (0.10 - 0.006 * dampen)
        speed.y += diffY * dist * (0.10 - 0.006 * dampen)
        
        speed.x += (gyroDir.x * speedFactor)
        speed.y += (gyroDir.y * speedFactor)
        
        let decay = 0.96 + 0.015 * dampen
        
        offset.x += speed.x
        offset.y += speed.y
        
        if frame.origin.y + offset.y <= boundingBox.origin.y {
            offset.y = boundingBox.origin.y - frame.origin.y
            speed.y = fabs(speed.y)
        } else if frame.origin.y + offset.y + frame.size.height >= boundingBox.origin.y + boundingBox.size.height {
            offset.y = boundingBox.origin.y + boundingBox.size.height - frame.size.height - frame.origin.y
            speed.y = -fabs(speed.y)
        }
        
        speed.x *= decay
        speed.y *= decay
        
        imageView.transform = CGAffineTransform.init(translationX: offset.x, y: offset.y)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
