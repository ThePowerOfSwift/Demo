//
//  HomeMenuHeader.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/14/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class HomeMenuHeader: UIView {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    weak var homeMenu: HomeMenuViewController?
    
    var letters = [HomeMenuLetter]()
    var firstLayout: Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    deinit {
        print("Header deinit..")
        
    }
    
    func setUp() {
        clipsToBounds = false
        isMultipleTouchEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if letters.count == 0 {
            
            for i in 0..<6 {
                let imagePath = "title_letter_0\(i)"
                if let letterImage = UIImage(named: imagePath) {
                    let letter = HomeMenuLetter(frame: CGRect.zero)
                    addSubview(letter)
                    letter.setUp(withImage: letterImage)
                    letters.append(letter)
                    
                    if i == 0 { letter.dampen = 0.8 }
                    if i == 1 { letter.dampen = 0.2 }
                    if i == 2 { letter.dampen = 0.45 }
                    if i == 3 { letter.dampen = 0.72 }
                    if i == 4 { letter.dampen = 0.36 }
                    if i == 5 { letter.dampen = 0.57 }
                    
                    //dampen
                }
            }
        }
        
        if letters.count > 0 {
            var totalWidth: CGFloat = 0.0
            
            for letter in letters {
                totalWidth += letter.width
            }
            
            if totalWidth > 0 {
                var left: CGFloat = width / 2.0 - totalWidth / 2.0
                for letter in letters {
                    letter.frame = CGRect(x: left, y: height / 2.0 - letter.height / 2.0, width: letter.width, height: letter.height)
                    left += letter.width
                }
            }
        }
    }
    
    func update() {
        
        
        let gyroDir = ApplicationController.shared.gyroDir
        
        for letter in letters {
            letter.update(withGyroDir: gyroDir, withBoundingBox: bounds)
        }
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
