//
//  Categary.swift
//  SwiftProject
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

//extension ImageMaker where Base: UIImage  {
//    
//}


extension UIImage {
    static func getImageWithColor(_ color : UIColor) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }
}


//extension String {
//    func isEmpty() -> Bool{
//        return
//    }
//}

