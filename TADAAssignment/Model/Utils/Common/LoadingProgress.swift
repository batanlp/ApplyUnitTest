//
//  LoadingProgress.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit

class LoadingProgress: NSObject {
    
    var isLoading: Bool = false
    var mainView: UIView?
    let loadingSize = 50

    static let shared = LoadingProgress()
    override init() {
    }
    
    func addLoading() {
        if (isLoading) {
            return
        }
        let bundle = Bundle(for: LoadingProgress.self)
        isLoading = true
        let topVC = UIApplication.topViewController()
       
        mainView = UIView(frame: (topVC.self?.view.frame)!)
        mainView!.backgroundColor = .clear
        topVC!.view.insertSubview(mainView!, at: 0)
        topVC?.view.bringSubviewToFront(mainView!)
        
        let imgView = UIImageView(frame:CGRect(x: Int(mainView!.frame.size.width)/2 - loadingSize/2,  y: Int(mainView!.frame.size.height)/2 - loadingSize/2, width: loadingSize, height: loadingSize))
        imgView.image = UIImage(named: "ic_logo.png", in: bundle, compatibleWith: nil)
        imgView.contentMode = .scaleAspectFit
        
        let imgView1 = UIImageView(frame:CGRect(x: Int(mainView!.frame.size.width)/2 - loadingSize/2,  y: Int(mainView!.frame.size.height)/2 - loadingSize/2, width: loadingSize, height: loadingSize))
        imgView1.image = UIImage(named: "ic_circleProgress.png", in: bundle, compatibleWith: nil)
        mainView!.addSubview(imgView1)
        mainView!.addSubview(imgView)
        if imgView1.layer.animation(forKey: "rotationanimationkey") == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = 1
            rotationAnimation.repeatCount = Float.infinity
            imgView1.layer.add(rotationAnimation, forKey: "rotationanimationkey")
        }
    }
    
    func removeLoading() {
        if (isLoading) {
            isLoading = false
            mainView?.removeFromSuperview()
        }
    }
}
