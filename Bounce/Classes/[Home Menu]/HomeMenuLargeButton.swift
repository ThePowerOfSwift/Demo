//
//  HomeMenuLargeButton.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/17/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class HomeMenuLargeButton: HomeMenuButton {
    
    var imageIcon: UIImage?
    
    var imageIconPath: String? {
        didSet {
            if let path = imageIconPath {
                imageIcon = UIImage(named: path)
            }
        }
    }
    
    override func drawImage() {
        
        let rect = bounds
        
        var imageLeft: CGFloat = 0.0
        
        if let img = imageIcon {
            
            //Figure out where the image would center vertically, and inset it horizontally the same amount.
            
            var pos = CGPoint.zero
            let cy = rect.size.height / 2.0
            
            let factor: CGFloat = 1.0 - highlightAlpha * 0.135
            
            let imageWidth: CGFloat = img.size.width * factor
            let imageHeight: CGFloat = img.size.height * factor
            
            pos.x = cy - imageWidth / 2.0
            pos.y = cy - imageHeight / 2.0
            
            let imgRect = CGRect(x: pos.x, y: pos.y, width: imageWidth, height: imageHeight)
            img.draw(in: imgRect, blendMode: .normal, alpha: 1.0)
            
            imageLeft += cy * 1.7
            imageLeft -= highlightAlpha * cy * 0.03
            
        }
        
        if let img = image {
            var pos = CGPoint.zero
            let cy = rect.size.height / 2.0
            pos.x = imageLeft
            pos.y = CGFloat(Int(cy - img.size.height / 2.0 + 0.5))
            let imgRect = CGRect(x: pos.x, y: pos.y, width: img.size.width, height: img.size.height)
            img.draw(in: imgRect, blendMode: .normal, alpha: 1.0)
        }
    }
}
