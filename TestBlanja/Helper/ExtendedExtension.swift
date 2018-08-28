//
//  ExtensionHelper.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import UIKit
import SDWebImage

extension UIView {
    @IBInspectable
    var cornerRadius:CGFloat {
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get{
            return layer.cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth:CGFloat {
        set{
            layer.borderWidth = newValue
        }
        get{
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor:UIColor {
        set{
            layer.borderColor = newValue.cgColor
        }
        get{
            return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor)
        }
    }
}

extension UIImageView {
    func setImageURL(url:String, placeholder:UIImage? = nil){
        var ph = self.image
        if let _ = placeholder {
            ph = placeholder
        }
        guard let urls = URL(string: url) else{return}
        self.sd_setImage(with: urls, placeholderImage: ph, options:.delayPlaceholder) { (image, error, type, url) in
            if let e = error {
                print("error \(e)")
            }
            
        }
    }
}
