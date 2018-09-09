//
//  CarousalLayout.swift
//  CardAnimation
//
//  Created by Manas Mishra on 09/09/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

class CarousalLayout: UICollectionViewFlowLayout {
    open var inset: CGFloat = 0.0
    
    
    /// Initialize a new carousel-style layout
    ///
    /// - parameter inset: The carousel inset
    ///
    /// - returns: A new carousel layout instance
    convenience init(withCarouselInset inset: CGFloat = 0.0) {
        self.init()
        self.inset = inset
    }
    override open func prepare() {
        
        guard let collectionViewSize = collectionView?.frame.size else { return }
        
        // Set itemSize based on total width and inset
        itemSize = collectionViewSize
        itemSize.width = 300 //itemSize.width - (inset * 2)
        itemSize.height = 200
        
        // Set scrollDirection and paging
        scrollDirection = .vertical
        collectionView?.isPagingEnabled = true
        
        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0
        
        sectionInset = UIEdgeInsets(top: 0.0, left: inset, bottom: 0.0, right: inset)
        footerReferenceSize = CGSize.zero
        headerReferenceSize = CGSize.zero
    }


}
