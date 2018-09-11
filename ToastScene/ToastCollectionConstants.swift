//
//  ToastCollectionConstants.swift
//  ToastScene
//
//  Created by Manas Mishra on 09/09/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

var screenMiddlePoint: CGFloat {
    return screenHeight/2
}
var toastMainViewBackgroundColor: UIColor {
    return .red
}
let BackgroundGifImageName = "bubble4"

var toastItemSize: CGSize {
    return CGSize(width: screenWidth - 60, height: screenHeight/4)
}

let ToastItemCellIdentifier = "ToastItemCollectionViewCell"

func getScale(offSet: CGFloat, cellY: CGFloat) -> CGFloat {
    let actualY = cellY - offSet + 60
    var scale: CGFloat = 0
    if actualY > (screenMiddlePoint) {
        scale = (1 - ((actualY - screenMiddlePoint)/screenMiddlePoint))
    } else {
        scale = actualY / screenMiddlePoint
    }
    scale = (scale < 0) ? -scale : scale
    print("Scale: \(scale)")
    return scale
}

/*
extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}*/
