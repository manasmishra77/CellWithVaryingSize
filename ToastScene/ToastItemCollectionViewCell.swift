//
//  ToastItemCollectionViewCell.swift
//  ToastScene
//
//  Created by Manas Mishra on 09/09/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

class ToastItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var toastLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - IBOutlets
    
    // This property should be connected to the main cell subview
    @IBOutlet public var mainView: UIView!
    
    // MARK: - Overrides
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        scale(scale: getScale(offSet: 0, cellY: self.frame.origin.y))
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        mainView.transform = CGAffineTransform.identity
        mainView.alpha = 1.0
    }
    
    /// Scale the cell when it is scrolled
    ///
    /// - parameter carouselInset: The inset of the related SPBCarousel view
    open func scale(withCarouselInset carouselInset: CGFloat = 0, contentOffSet: CGFloat = 0, scale: CGFloat) {
        let affineIdentity = CGAffineTransform.identity
        
        // Scale our mainView and set it's alpha value
        
        mainView.transform = affineIdentity.scaledBy(x: scale, y: scale)
        mainView.alpha = scale
        
        // ..also..round the corners
        mainView.layer.cornerRadius = 20
        /*
         // Ensure we have a superView, and mainView
         guard let superview = superview,
         let mainView = mainView else { return }
         
         // Get our absolute origin value
         let originX = superview.convert(frame, to: superview.superview).origin.x
         
         // Calculate our actual origin.x value using our inset
         let originXActual = originX - carouselInset
         
         let width = frame.size.width
         
         // Calculate our scale values
         let scaleCalculator = fabs(width - fabs(originXActual))
         let percentageScale = (scaleCalculator/width)
         
         //let randomCGFloat =  CGFloat.random(lower: 0, 1)
         
         let rect = getRectFor(superview, viewToBeObserved: self)
         var rectY = rect.origin.y
         
         // let scale = getScale(Float(rectY))
         //        print("View frame -- \(scale)")
         guard scale <= 1, scale >= 0 else {
         return
         }
         
         
         let scaleValue = scaleMinimum
         + (percentageScale/scaleDivisor)
         
         let alphaValue = alphaMinimum
         + (percentageScale/scaleDivisor)
         
         let affineIdentity = CGAffineTransform.identity
         
         // Scale our mainView and set it's alpha value
         
         mainView.transform = affineIdentity.scaledBy(x: scale, y: scale)
         mainView.alpha = scale
         
         // ..also..round the corners
         mainView.layer.cornerRadius = 20*/
    }

}

