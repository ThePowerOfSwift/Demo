//
//  LoadViewController.swift
//  Bounce
//
//  Created by Raptis, Nicholas on 11/22/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

class LoadViewController : UIViewController, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var mainContainer: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            layoutLandscape = Device.isLandscape
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    //Before the orientation actually is landscape, will it be switching to landscape?
    var layoutLandscape:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppDelegate.root.addUpdateObject(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        AppDelegate.root.removeUpdateObject(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size.width > size.height {
            layoutLandscape = true
        } else {
            layoutLandscape = false
        }
        
        //collectionView!.reloadData()
        reloadData()
        
        coordinator.animate(alongsideTransition: {
            [weak weakSelf = self] (id:UIViewControllerTransitionCoordinatorContext) in
            
            
            }, completion: nil)
    }
    
    func setUp() {
        ApplicationController.shared.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            [weak weakSelf = self] in
            weakSelf?.collectionView.reloadData()
        }
    }
    
    func update() {
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y <= 0.0 {
            
            //Do something to animate the top bar, etc..
            
            var offset:CGFloat = -scrollView.contentOffset.y
            var percent = offset / 90.0
            if percent >= 1.0
            {
                percent = 1.0
                //refreshSpinner?.isLoading = true
                
            }
            
            //refreshSpinner?.revealPercent = percent
            
        } else {
            
        }
        
        
    }
    
    //Override this, here for completion's sake.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    //Override this, here for completion's sake.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let result = UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: 256.0, height: 128.0))
        result.backgroundColor = UIColor.cyan
        return result
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let appWidth = ApplicationController.shared.width
        var width = (appWidth - (12.0 * 3.0)) / 2.0
        if Device.isTablet {
            if layoutLandscape {
                width = (appWidth - (12.0 * 5.0)) / 4.0
            } else {
                width = (appWidth - (12.0 * 4.0)) / 3.0
            }
        } else {
            if layoutLandscape {
                width = (appWidth - (12.0 * 4.0)) / 3.0
            }
        }
        let height = CGFloat(Int(width * 0.75 + 30.0))
        width = CGFloat(Int(width))
        return CGSize(width: width, height: height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
