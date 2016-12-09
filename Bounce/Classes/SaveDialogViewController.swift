//
//  SaveDialogViewController.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/22/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class SaveDialogViewController : UIViewController, UIGestureRecognizerDelegate {

    var tapRecognizer:UITapGestureRecognizer!
    
    var locked: Bool = true
    
    @IBOutlet weak var dialogTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var saveDialog: SaveDialog! {
        didSet {
            saveDialog.saveDialogViewController = self
            
            
        }
    }
    
    var _blurEffect:UIBlurEffect?
    var blurEffect:UIBlurEffect {
        if _blurEffect == nil {
            //_blurEffect = UIBlurEffect(style: .extraLight)
            _blurEffect = UIBlurEffect(style: .dark)
        }
        return _blurEffect!
    }
    
    var _blurEffectView:UIVisualEffectView?
    var blurEffectView:UIVisualEffectView {
        if _blurEffectView == nil {
            _blurEffectView = UIVisualEffectView(frame: view.bounds)
        }
        return _blurEffectView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveDialog.saveDialogViewController = self
        saveDialog.layer.cornerRadius = 4.0
        saveDialog.layer.borderWidth = 0.5
        saveDialog.layer.borderColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0).cgColor
        
        view.backgroundColor = UIColor.clear
        
        
        let y = CGFloat(Int((view.frame.size.height / 2.0) - (saveDialog.frame.size.height / 2.0)))
        
        dialogTopConstraint.constant = y
        
        view.setNeedsUpdateConstraints()
        //saveDialog.setNeedsUpdateConstraints()
        
        view.layoutIfNeeded()
            
            
        //
        
        //#selector(self.keyboardWillShow(notification:))
        
        NotificationCenter.default.addObserver(self, selector: #selector(SaveDialogViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SaveDialogViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //keyboardWillShow(notification: nil)
        
        
        
        //NotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardShown:), name: NSNotification, object: nil)
        
        animateIn()
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapRecognizer.delegate = self
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func didTap(_ gr:UITapGestureRecognizer) -> Void {
        self.performSelector(onMainThread: #selector(didTapMainThread(_:)), with: gr, waitUntilDone: true, modes: [RunLoopMode.commonModes.rawValue])
    }
    
    func didTapMainThread(_ gr:UITapGestureRecognizer) -> Void {

        if saveDialog.textFieldName.isFirstResponder {
            saveDialog.textFieldName.resignFirstResponder()
        } else {
            animateOut()
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if locked { return false }
        
        let pos = gestureRecognizer.location(in: view)
        if saveDialog.frame.contains(pos) { return false }
        //if bottomMenu.frame.contains(pos) { return false }
        //if allowTouch == false { return false }
        
        return true
    }
    
    func animateIn() {
        blurEffectView.frame = view.bounds
        if blurEffectView.superview == nil {
            view.insertSubview(blurEffectView, belowSubview: saveDialog!)
        }
        saveDialog.alpha = 0.0
        UIView.animate(withDuration: 0.33, delay: 0.05, options: .curveLinear, animations: { [weak weakSelf = self] in
            weakSelf?.blurEffectView.effect = weakSelf?.blurEffect
            weakSelf?.saveDialog.alpha = 1.0
            }, completion: { [weak weakSelf = self]  didFinish in
                weakSelf?.locked = false
        })
    }
    
    func animateOut() {
        
        if locked { return }
        
        locked = true
        
        UIView.animate(withDuration: 0.33, delay: 0.05, options: .curveLinear, animations: { [weak weakSelf = self] in
            weakSelf?.blurEffectView.effect = nil
            weakSelf?.saveDialog.alpha = 0.0
            }, completion: { [weak weakSelf = self] (didFinish:Bool) in
                weakSelf?.blurEffectView.removeFromSuperview()
                ApplicationController.shared.root.killPopover(viewController: self)
        })
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        let info  = notification.userInfo!
        if let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey] as? AnyObject {
        
            if let rawFrame = value.cgRectValue {
                let keyboardFrame = view.convert(rawFrame, from: view)
                
                
                let y = CGFloat(Int(((view.frame.size.height - keyboardFrame.size.height) / 2.0) - (saveDialog.frame.size.height / 2.0)))
                
                dialogTopConstraint.constant = y
                
                view.setNeedsUpdateConstraints()
                saveDialog.setNeedsUpdateConstraints()
                
                UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: { [weak weakSelf = self] in
                    
                    
                    //weakSelf?.saveDialog.layoutIfNeeded()
                    weakSelf?.view.layoutIfNeeded()
                    
                    
                    //weakSelf?.saveDialog.alpha = 1.0
                    }, completion: { [weak weakSelf = self]  didFinish in
                        //weakSelf?.locked = false
                })
                
                
                print("KeyboardFrame = \(keyboardFrame.origin.x), \(keyboardFrame.origin.y), \(keyboardFrame.size.width), \(keyboardFrame.size.height)")
                
            }
            
        }
        
        //print("keyboardFrame: \(keyboardFrame)")
        
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        
        let y = CGFloat(Int((view.frame.size.height / 2.0) - (saveDialog.frame.size.height / 2.0)))
        
        dialogTopConstraint.constant = y
        
        view.setNeedsUpdateConstraints()
        saveDialog.setNeedsUpdateConstraints()
        
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: { [weak weakSelf = self] in
            
            //weakSelf?.saveDialog.layoutIfNeeded()
            weakSelf?.view.layoutIfNeeded()
            
            //weakSelf?.saveDialog.alpha = 1.0
            }, completion: { [weak weakSelf = self]  didFinish in
                //weakSelf?.locked = false
        })
        
        
    }
    
    deinit {
        
        print("DEINIT - SaveDialogViewController")
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
