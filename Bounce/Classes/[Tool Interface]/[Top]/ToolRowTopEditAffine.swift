//
//  ToolRowTopEdit.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 10/25/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class ToolRowTopEditAffine: ToolRow
{
    
    @IBInspectable @IBOutlet weak var buttonTestSave:TBButton! {
        didSet {
            buttonTestSave.setImages(path: "tb_btn_select_next_blob", pathSelected: "tb_btn_select_next_blob_down")
        }
    }
    
    @IBInspectable @IBOutlet weak var buttonTestLoad:TBButton! {
        didSet {
            buttonTestLoad.setImages(path: "tb_btn_add_blob", pathSelected: "tb_btn_add_blob_down")
        }
    }
    
    @IBInspectable @IBOutlet weak var buttonFlipH:TBButton! {
        didSet {
            buttonFlipH.setImages(path: "tb_btn_add_blob", pathSelected: "tb_btn_add_blob_down")
        }
    }
    
    @IBInspectable @IBOutlet weak var buttonFlipV:TBButton! {
        didSet {
            buttonFlipV.setImages(path: "tb_btn_add_blob", pathSelected: "tb_btn_add_blob_down")
        }
    }
    
    override func refreshUI() {
        super.refreshUI()
        UIUpdateSelection()
        UIUpdateZoom()
        UIUpdateSceneMode()
    }
    
    override func segmentSelected(segment:TBSegment, index: Int) {
        
    }
    
    override func checkBoxToggled(checkBox:TBCheckBox, checked: Bool) {
        
    }
    
    func UIUpdateSelection() {
        if ApplicationController.shared.selectedBlob != nil {
            //buttonDeleteBlob.isEnabled = true
            //buttonCloneBlob.isEnabled = true
        } else {
            //buttonDeleteBlob.isEnabled = false
            //buttonCloneBlob.isEnabled = false
        }
    }
    
    func UIUpdateZoom() {
        
    }
    
    func UIUpdateSceneMode() {
        
    }
    
    @IBAction func clickFlipH(sender: AnyObject) {
        //ToolActions.addBlob()
        ToolActions.flipH()
    }
    
    @IBAction func clickFlipV(sender: AnyObject) {
        ToolActions.flipV()
        //ToolActions.deleteBlob()
    }
    
    @IBAction func clickTestSave(sender: AnyObject) {
        ToolActions.save()
        //ToolActions.addBlob()
    
    }
    
    @IBAction func clickTestLoad(sender: AnyObject) {
        //ToolActions.deleteBlob()
        
    }
    
    override func handleSceneReady() {
        super.handleSceneReady()
        
    }
    
    override func handleZoomModeChanged() {
        super.handleZoomModeChanged()
        UIUpdateZoom()
    }
    
    override func handleSceneModeChanged() {
        super.handleSceneModeChanged()
        UIUpdateSceneMode()
    }
    
    override func handleEditModeChanged() {
        super.handleEditModeChanged()
        
    }
    
    override func handleViewModeChanged() {
        super.handleViewModeChanged()
        
    }
    
    override func handleBlobSelectionChanged() {
        super.handleBlobSelectionChanged()
        UIUpdateSelection()
    }
    
}

