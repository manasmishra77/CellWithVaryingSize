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

var toastItemSize: CGSize {
    return CGSize(width: screenWidth - 30, height: screenHeight/4)
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
