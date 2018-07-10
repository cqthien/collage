//  Project name: SimpleCollage
//  File name   : CollageVC.swift
//
//  Author      : Thien Chu
//  Created date: 3/1/18
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2018 Home. All rights reserved.
//  --------------------------------------------------------------

import UIKit


final class CollageVC: UIViewController {

    var collageViews = [CollageView]()

    @IBOutlet weak var containerView: UIView!
    
    // MARK: View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        
        let colllage = CollageDTO(
            name: "S02",
            views: ["viewA", "viewB"],
            constraints: [
                "|-padding-[viewA]-padding-|",
                "V:|-padding-[viewA]-padding-|",
                "|-padding-[viewB]-padding-|",
                "V:|-padding-[viewB]-padding-|"
            ],
            type: .custom,
            paths: [
                "viewA": [
                    Cordinator(x: 0.0, y: 0.0, position: .top),
                    Cordinator(x: 1.0, y: 1.0, position: .right),
                    Cordinator(x: 0.0, y: 1.0)
                ],
                "viewB": [
                    Cordinator(x: 1.0, y: 1.0, position: .bottom),
                    Cordinator(x: 0.0, y: 0.0, position: .left),
                    Cordinator(x: 1.0, y: 0.0)
                ]
            ]
        )
        
        loadCollage(with: colllage)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
    }
    
    // MARK: View's orientation handler
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UI_USER_INTERFACE_IDIOM() == .pad {
            return .all
        } else {
            return [.portrait, .portraitUpsideDown]
        }
    }
    
    // MARK: View's status handler
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .`default`
    }
    
    // MARK: View's transition event handler
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // TODO: Transfer data between views during presentation here.
    }

    // MARK: Class's public methods
}

// MARK: View's key pressed event handlers
extension CollageVC {

    @IBAction func loadButtonPressed(sender: AnyObject) {
        let images = [UIImage(named: "landscape"), UIImage(named: "landscape2")]
        _ = collageViews.enumerated().map { (index, collageView) in
            if 0 <= index, index < images.count {
                display(image: images[index], collage: collageView)
            }
        }
        
        debugPrint("Here")
    }
}

// MARK: Class's private methods
fileprivate extension CollageVC {

    fileprivate func localize() {
        // TODO: Localize view's here.
    }
    fileprivate func visualize() {
        // TODO: Visualize view's here.
    }
    
    fileprivate func loadCollage(with collage: CollageDTO) {
        containerView.subviews.forEach { (subView) in
            subView.removeFromSuperview()
        }
        
        var views = [String: CollageView]()
        collage.views.forEach { (viewName) in
            let collageView = CollageView()
            collageView.backgroundColor = getRandomColor()
            collageView.translatesAutoresizingMaskIntoConstraints = false
            collageView.collage = collage
            collageView.paths = collage.paths?[viewName]
            containerView.addSubview(collageView)
            
            views[viewName] = collageView
            
            collageViews.append(collageView)
        }
        
        var allConstraints = [NSLayoutConstraint]()
        collage.constraints.forEach { (constraint) in
            let metrics = ["padding": 10, "spacing": 10]
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: metrics, views: views)
            
            allConstraints.append(contentsOf: constraints)
        }
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    func display(image i: UIImage?, collage collageView: CollageView) {
        let currentScrollView = collageView.scrollView
        currentScrollView?.subviews.forEach({ $0.removeFromSuperview() })
        currentScrollView?.superview?.backgroundColor = .clear
        
        let view = UIImageView(image: i)
        updateCollage(collageView, with: view)
    }
    
    func updateCollage(_ collageView: CollageView?, with imageView: UIImageView) {
        let currentScrollView = collageView?.scrollView
        
        collageView?.imageView = imageView
        
        imageView.translatesAutoresizingMaskIntoConstraints = true
        currentScrollView?.addSubview(imageView)
        
        guard let image = imageView.image, let imageFrame = currentScrollView?.bounds else {
            return
        }
        
        // Update scrollview content size, min & max scale
        currentScrollView?.contentSize = image.size
        
        let scaleHeight = imageFrame.size.height / image.size.height
        let scaleWidth = imageFrame.size.width / image.size.width
        let minScale = max(scaleWidth, scaleHeight)
        
        currentScrollView?.minimumZoomScale = minScale
        currentScrollView?.maximumZoomScale = 2.0
        currentScrollView?.zoomScale = minScale
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
