//
//  LoadingAnimation.swift
//  SwiftProject
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation


class LoadingAnimation: UIImageView {
    static let instance = LoadingAnimation.init(frame: CGRect.init(x: screenW/2 - 75.0/2, y: screenH/2 - 70.0/2, width: 75.0, height: 70.0))
    
    private class func shareInstance() -> LoadingAnimation {
        
        if instance.animationImages == nil {
            var allAry = [UIImage]()
            for i in 0...4 {
                let string = "loadgif" + String(i)
                allAry.append((UIImage.init(named: string)!))
            }
            instance.image = UIImage.init(named: "loadgif0")
            instance.animationImages = allAry
            instance.animationDuration = 0.4
            instance.animationRepeatCount = 0
        }
        return .instance
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class func show() -> Void {
        LoadingAnimation.shareInstance().startAnimating()
        print("  2222222")
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.addSubview(instance)
        }
    }
    
    class func dismiss() -> Void{
        instance.removeFromSuperview();
        instance.stopAnimating()
        
    }
}
