//
//  SHTabBarController.swift
//  SwiftProject
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height
let footH = 50.0

class SHTabBarController: UITabBarController {
    
    let homeNC : UINavigationController!
    let storeNC : UINavigationController!
    let titlesAry : NSArray
    var allImgs : NSMutableArray
    var lastImg : UIImageView? = nil
    
    init() {
        let homeVc = HomeController()
        self.homeNC = UINavigationController.init(rootViewController: homeVc)
        
        let storeVc = StoreController()
        self.storeNC = UINavigationController.init(rootViewController: storeVc)
        
        titlesAry = NSArray.init(array: ["首页","商城", "我的"])
        allImgs = NSMutableArray()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.viewControllers = [HomeController() , StoreController(), UserController()]
        self.setBaseViews()
        self.navigationItem.title = "首页";
        view.backgroundColor = UIColor.white
    }
    
    func setBaseViews() -> Void {
        let imagesAry = [UIImage.init(named: "home_nor"), UIImage.init(named: "mall1"),UIImage.init(named: "me_nor")]
        let imagesAryH = [UIImage.init(named: "home_sel"), UIImage.init(named: "mall2"), UIImage.init(named: "me_sel")]
        
        
        let contentView = UIView.init(frame: CGRect.init(x: 0.0, y: screenH - CGFloat(footH), width: screenW, height: screenH))
        contentView.backgroundColor = UIColor.white
        self.view .addSubview(contentView)
        
        let maxw = screenW / CGFloat(imagesAry.count)
        for i in 0  ..< imagesAry.count  {
            
            let btn = UIButton.init(type: UIButtonType.custom)
            btn.frame = CGRect.init(x: maxw * CGFloat(i), y: 0, width: maxw, height: contentView.frame.size.height)
            btn.addTarget(self, action: #selector(clickedIndex(sender:)), for: UIControlEvents.touchUpInside)
            btn.tag = i
            
            let img = imagesAry[i]
            let imageV = UIImageView.init(image: img)
            imageV.frame = CGRect.init(x: maxw/2 - (img?.size.width)!/2 + btn.frame.origin.x, y: 5.0, width: (img?.size.width)!, height: (img?.size.height)!)
            imageV.highlightedImage = imagesAryH[i];
            
            if i == 0 {
                imageV.isHighlighted = true
                lastImg = imageV
            }
            allImgs.add(imageV)
            
            let lab = UILabel.init(frame: CGRect.init(x: btn.frame.origin.x, y: imageV.frame.origin.y + imageV.frame.size.height + CGFloat(8.0), width: maxw, height: 14))
            lab.font = UIFont.systemFont(ofSize: 14)
            lab.text = titlesAry.object(at: i) as? String
            lab.textAlignment = NSTextAlignment.center
            
            contentView .addSubview(imageV)
            contentView.addSubview(lab)
            contentView .addSubview(btn)
        }
    }
    
    
    func clickedIndex(sender: UIButton) -> Void {
        
        let selectedImg = allImgs.object(at: sender.tag) as! UIImageView
        selectedImg.isHighlighted = true
        lastImg?.isHighlighted = false
        lastImg = selectedImg
        
        self.selectedViewController = viewControllers?[sender.tag]
        navigationItem.title = String(describing: (self.titlesAry.object(at: sender.tag)))
    }
    
}

















