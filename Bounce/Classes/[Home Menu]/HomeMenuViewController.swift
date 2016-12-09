//
//  HomeMenuViewController.swift
//  SwiftFunhouse
//
//  Created by Raptis, Nicholas on 7/18/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class HomeMenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    //@IBOutlet weak var buttonCreate: HMButton!
    //@IBOutlet weak var buttonLoad: HMButton!
    //@IBOutlet weak var buttonContinue: HMButton!
    //@IBOutlet weak var buttonUpgrade: HMButton!
    //@IBOutlet weak var cloudTest: HMButton!
    //@IBOutlet weak var glTest: HMButton!
    
    
    var loadPath:String? = "test_ipad_info.plist"
    
    var importImage: UIImage?
    
    @IBOutlet weak var header: HomeMenuHeader! { didSet { header.homeMenu = self } }
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var mainButtons: HomeMenuMainButtons! { didSet { mainButtons.homeMenu = self } }
    @IBOutlet weak var mainSubscription: HomeMenuMainSubscription! { didSet { mainSubscription.homeMenu = self } }
    @IBOutlet weak var mainSubscriptionAlt: HomeMenuMainSubscription! { didSet { mainSubscriptionAlt.homeMenu = self } }
    
    
    @IBOutlet weak var mainSubscriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainSubscriptionAltWidthConstraint: NSLayoutConstraint!
    
    //mainSubscription
    
    
    var tiltOffsetMax: CGFloat = 29.75
    var tiltOffset = CGPoint.zero
    var tiltResetAnimation = false
    var tiltResetTime: Int = 30
    var tiltResetTimer: Int = 0
    var tiltResetStartOffset = CGPoint.zero
    var tiltResetEndOffset = CGPoint.zero
    
    var headerHeight: CGFloat {
        if Device.isLandscape {
            return headerHeightLandscape
        } else {
            return headerHeightPortrait
        }
    }
    
    var headerHeightLandscape: CGFloat {
        if Device.isTablet {
            return Device.landscapeHeight * 0.2
        } else {
            return Device.landscapeHeight * 0.2
        }
    }
    
    var headerHeightPortrait: CGFloat {
        var result: CGFloat = Device.portraitHeight * 0.15
        
        if Device.isTablet {
            result = Device.portraitHeight * 0.20
            //
            
        } else {
            if result < 100 { result = 100.0 }
            //return Device.portraitHeight * 0.18
        }
        
        return result
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ApplicationController.shared.navigationController?.setNavigationBarHidden(true, animated: true)
        AppDelegate.root.addUpdateObject(self)
        
        if Device.isLandscape {
            refreshSubscriptionConstraints(withLandscape: true)
            mainSubscription.alpha = 0.0
            mainSubscriptionAlt.alpha = 1.0
        } else {
            refreshSubscriptionConstraints(withLandscape: false)
            mainSubscription.alpha = 1.0
            mainSubscriptionAlt.alpha = 0.0
        }
        view.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.root.removeUpdateObject(self)
    }
    
    override func viewDidLoad() {
        //self.clickImport(HMButton())
        
        header?.heightConstraint.constant = headerHeight
        header?.setNeedsUpdateConstraints()
        
    }
    
    
    func showImagePicker(_ sender:UIButton?) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        AppDelegate.root.present(imagePicker, animated: true, completion: {})
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tiltResetAnimation = true
        tiltResetTimer = 0
        tiltResetStartOffset = tiltOffset
        tiltResetEndOffset = CGPoint.zero
        
        var landscape: Bool = false
        if size.width > size.height {
            landscape = true
        }
        
        if landscape {
            header?.heightConstraint.constant = headerHeightLandscape
        } else {
            header?.heightConstraint.constant = headerHeightPortrait
        }
        
        header?.setNeedsLayout()
        
        refreshSubscriptionConstraints(withLandscape: landscape)
        
        coordinator.animate(alongsideTransition: { [weak weakSelf = self] (id:UIViewControllerTransitionCoordinatorContext) in
            weakSelf?.header?.layoutIfNeeded()
            weakSelf?.view.layoutIfNeeded()
            if landscape {
                weakSelf?.mainSubscription.alpha = 0.0
                weakSelf?.mainSubscriptionAlt.alpha = 1.0
            } else {
                weakSelf?.mainSubscription.alpha = 1.0
                weakSelf?.mainSubscriptionAlt.alpha = 0.0
            }
            }, completion: nil)
    }
    
    func update() {
        
        if tiltResetAnimation {
            
            tiltResetTimer += 1
            if tiltResetTimer >= tiltResetTime {
                
                tiltResetAnimation = false
                tiltOffset = tiltResetEndOffset
                
            } else {
                let percent = CGFloat(tiltResetTimer) / CGFloat(tiltResetTime)
                tiltOffset.x = tiltResetStartOffset.x + (tiltResetEndOffset.x - tiltResetStartOffset.x) * percent
                tiltOffset.y = tiltResetStartOffset.y + (tiltResetEndOffset.y - tiltResetStartOffset.y) * percent
            }
            
            
            
        } else {
            let dir = ApplicationController.shared.gyroDir
            if fabs(dir.x) > 0.1 || fabs(dir.y) > 0.1 {
                tiltOffset.x = (tiltOffset.x + dir.x * 1.21) * 0.985
                tiltOffset.y = (tiltOffset.y + dir.y * 1.21) * 0.985
            }
        }
        
        if tiltOffset.x > tiltOffsetMax { tiltOffset.x = tiltOffsetMax }
        if tiltOffset.x < -tiltOffsetMax { tiltOffset.x = -tiltOffsetMax }
        if tiltOffset.y > tiltOffsetMax { tiltOffset.y = tiltOffsetMax }
        if tiltOffset.y < -tiltOffsetMax { tiltOffset.y = -tiltOffsetMax }
        
        var t = CGAffineTransform.identity
        t = t.translatedBy(x: tiltOffset.x, y: tiltOffset.y)
        imageViewBackground.transform = t
        
        header.update()
        mainButtons.update()
        mainSubscription.update()
        mainSubscriptionAlt.update()
    }
    
    func refreshSubscriptionConstraints(withLandscape landscape: Bool) {
        if landscape {
            mainSubscriptionHeightConstraint.constant = 0.0
            mainSubscriptionAltWidthConstraint.constant = Device.landscapeWidth * 0.5
            
        } else {
            mainSubscriptionAltWidthConstraint.constant = 0.0
            mainSubscriptionHeightConstraint.constant = Device.portraitHeight * 0.3
        }
        
        mainSubscription.setNeedsUpdateConstraints()
        mainSubscriptionAlt.setNeedsUpdateConstraints()
        view.setNeedsUpdateConstraints()
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        let result = UIInterfaceOrientationMask.all
        return result
    }
    
    //func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool)
    //func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool)
    //func navigationControllerSupportedInterfaceOrientations(navigationController: UINavigationController) -> UIInterfaceOrientationMask
    //func navigationControllerPreferredInterfaceOrientationForPresentation(navigationController: UINavigationController) -> UIInterfaceOrientation
    //func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    //func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        for (key, obj) in info {
            print("key = \(key)")
            print("obj = \(obj)")
        }
        let pickerImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        guard let image = pickerImage , image.size.width > 32.0 && image.size.height > 32.0 else {
            self.dismiss(animated: true) { }
            return
        }
        importImage = image
        AppDelegate.root.dismiss(animated: true) { [weak weakSelf = self] in
            weakSelf?.performSegue(withIdentifier: "import_image", sender: nil)
        }
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        AppDelegate.root.dismiss(animated: true) { //[weak ws = self] in
            print("Finished Dismissing Image Picker")
        }
    }
    
    @IBAction func testPush(_ sender: UIButton) {
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "import_image" {
            if let image = importImage {
                if let importer = segue.destination as? ImageImportViewController {
                    importer.setUp(importImage: image, screenSize: self.view.bounds.size)
                    importImage = nil
                }
            }
        }
        
        if segue.identifier == "load" {
            
            if let loadVC = segue.destination as? LoadViewController {
                loadVC.setUp()
            }
        }
        
        /*
         if segue.identifier == "test_bounce" {
         if let bounce = segue.destination as? BounceViewController {
         bounce.loadScene(filePath: loadPath)
         }
         }
         */
        
    }
    
    /*
     @IBAction func clickImport(_ sender: HMButton) {
     importImage = UIImage(named: "test_card.jpg")
     self.performSegue(withIdentifier: "import_image", sender: nil)
     }
     
     @IBAction func clickContinueRecent(_ sender: HMButton) {
     loadPath = "recent_scene.json"
     ApplicationController.shared.preloadScene(withFile: loadPath!)
     
     performSegue(withIdentifier: "test_bounce", sender: nil)
     }
     */
    
    //
    
    
    
    func clickNew() {
        showImagePicker(nil)
    }
    
    func clickWeb() {
        //showImagePicker(sender)
        
    }
    
    func clickContinueLast() {
        //showImagePicker(sender)
    }
    
    func clickLoad() {
        
        performSegue(withIdentifier: "load", sender: nil)
        
        //load
        
    }
    
    func clickTest1() {
        testLoad(withName: "test_ipad_portrait_info.json")
    }
    
    func clickTest2() {
        testLoad(withName: "test_ipad_landscape_info.json")
    }
    
    func clickTest3() {
        testLoad(withName: "test_iphone5_portrait_info.json")
    }
    
    func clickTest4() {
        testLoad(withName: "test_iphone5_landscape_info.json")
    }
    
    func clickTest5() {
        testLoad(withName: "test_iphone6_landscape_info.json")
    }
    
    func clickTest6() {
        testLoad(withName: "test_iphone6_portrait_info.json")
    }
    
    func testLoad(withName name: String) -> Void {
        
        
        ApplicationController.shared.preloadScene(withFile: name)
        
        //preloadScene(withLandscape: isPortrait == false)
        if let bounce = ApplicationController.shared.getStoryboardVC("bounce") as? BounceViewController {
            
            bounce.loadViewIfNeeded()
            bounce.loadScene(filePath: name)
            ApplicationController.shared.navigationController?.setNavigationBarHidden(true, animated: true)
            ApplicationController.shared.navigationController?.setViewControllers([bounce], animated: true)
        }
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
}
