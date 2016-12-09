//
//  HomeMenuFooter.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/17/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class HomeMenuMainSubscription: UIView {

    
    @IBOutlet weak var buttonTest1: HomeMenuButton!
    @IBOutlet weak var buttonTest2: HomeMenuButton!
    @IBOutlet weak var buttonTest3: HomeMenuButton!
    @IBOutlet weak var buttonTest4: HomeMenuButton!
    @IBOutlet weak var buttonTest5: HomeMenuButton!
    @IBOutlet weak var buttonTest6: HomeMenuButton!
    
    
    @IBOutlet weak var iconButtonTest1: IconButton! {
        didSet {
            
            iconButtonTest1.setImages(path: "tb_btn_undo", pathSelected: "tb_btn_undo_down")
            
            //segMode.setImage(index: 1, path: "tb_seg_view", pathSelected: "tb_seg_view_selected")
            
            //buttonUndo.setImages(path: "tb_btn_undo", pathSelected: "tb_btn_undo_down")
            
            //iconButtonTest1.imagePathUp
        }
    }
    
    @IBOutlet weak var iconButtonTest2: IconButton! {
        didSet {
        iconButtonTest2.setImages(path: "tb_seg_view", pathSelected: "tb_seg_view_selected")
        }
    }
    
    @IBOutlet weak var iconButtonTest3: IconButton!
    
    
    weak var homeMenu: HomeMenuViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    deinit {
        print("Footer deinit..")
        
    }
    
    func setUp() {
        clipsToBounds = false
        isMultipleTouchEnabled = false
    }
    
    func update() {
        buttonTest1.update()
        buttonTest2.update()
        buttonTest3.update()
        buttonTest4.update()
        buttonTest5.update()
        buttonTest6.update()
    }
    
    @IBAction func clickTest1(_ sender: HomeMenuButton) {
        homeMenu?.clickTest1()
    }
    
    @IBAction func clickTest2(_ sender: HomeMenuButton) {
        homeMenu?.clickTest2()
    }
    
    @IBAction func clickTest3(_ sender: HomeMenuButton) {
        homeMenu?.clickTest3()
    }
    
    @IBAction func clickTest4(_ sender: HomeMenuButton) {
        homeMenu?.clickTest4()
    }
    
    @IBAction func clickTest5(_ sender: HomeMenuButton) {
        homeMenu?.clickTest5()
    }
    
    @IBAction func clickTest6(_ sender: HomeMenuButton) {
        homeMenu?.clickTest6()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
