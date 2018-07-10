//  Project name: SimpleCollage
//  File name   : CollageView.swift
//
//  Author      : Thien Chu
//  Created date: 2/28/18
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2018 Home. All rights reserved.
//  --------------------------------------------------------------

import UIKit


@IBDesignable
final class CollageView: UIView {

    // MARK: Class's properties
    
    var scrollView: UIScrollView!
    var backgroundImageView: UIImageView?
    var imageView: UIImageView!
    var collage: CollageDTO?
    var paths: [Cordinator]?

    // MARK: Class's constructors
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    // MARK: Class's public methods
    override func layoutSubviews() {
        super.layoutSubviews()
        visualize()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // Prevent empty context
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.saveGState()
        defer { context.restoreGState() }

        // TODO: Implement custom draw here.
    }
    override func updateConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["imageView": imageView, "scrollView": scrollView] as [String : Any]
        let vImageView = "V:|[imageView]|"
        let hImageView = "|[imageView]|"
        
        let vScrollView = "V:|[scrollView]|"
        let hScrollView = "|[scrollView]|"
        
        let hImageConstraints = NSLayoutConstraint.constraints(withVisualFormat: hImageView, options: [], metrics: nil, views: views)
        let vImageConstraints = NSLayoutConstraint.constraints(withVisualFormat: vImageView, options: [], metrics: nil, views: views)
        
        let hScrollConstraints = NSLayoutConstraint.constraints(withVisualFormat: hScrollView, options: [], metrics: nil, views: views)
        let vScrollConstraints = NSLayoutConstraint.constraints(withVisualFormat: vScrollView, options: [], metrics: nil, views: views)
        
        var allConstraints = hScrollConstraints
        allConstraints.append(contentsOf: vScrollConstraints)
        allConstraints.append(contentsOf: hImageConstraints)
        allConstraints.append(contentsOf: vImageConstraints)
        
        NSLayoutConstraint.activate(allConstraints)
        
        super.updateConstraints()
    }
}

// MARK: Class's private methods
fileprivate extension CollageView {

    // MARK: Class's private methods
    fileprivate func initialize() {
        // TODO: Initialize view's here.
        scrollView = UIScrollView()
        imageView = UIImageView()
        imageView.backgroundColor = UIColor.cyan
        scrollView.addSubview(imageView)
        
        self.addSubview(scrollView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    fileprivate func visualize() {
        // TODO: Visualize view's here.
        
        guard let collage = collage, let type = collage.type, type != .normal else {
            return
        }
        
        if type == .heart {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = UIBezierPath().drawHeart(with: frame, scale: 0.8).cgPath
            layer.mask?.removeFromSuperlayer()
            
            layer.mask = shapeLayer
        }
        else if type == .circle {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = UIBezierPath().drawCircle(with: frame, scale: 0.8).cgPath
            layer.mask?.removeFromSuperlayer()
            
            layer.mask = shapeLayer
        }
        else if type == .custom {
            guard let cordinators = paths else {
                return
            }
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = UIBezierPath().drawPolygon(with: frame, scale: 1, paths: cordinators).cgPath
            layer.mask?.removeFromSuperlayer()
            
            layer.mask = shapeLayer
        }
    }
    
    @objc fileprivate func handleTapGesture(_ sender: UITapGestureRecognizer) {
        debugPrint("\(#function)")
    }
}
