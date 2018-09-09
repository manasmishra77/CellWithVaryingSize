//
//  CarouselView.swift
//  CardAnimation
//
//  Created by Manas Mishra on 09/09/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

class CarouselView: UICollectionView {
    
    /// Override of the collection view content size to add an observer
    override open var contentSize: CGSize {
        didSet {
            
            guard let dataSource = dataSource,
                let invisibleScrollView = invisibleScrollView else { return }
            
            let numberSections = dataSource.numberOfSections?(in: self) ?? 1
            
            // Calculate total number of items in collection view
            var numberItems = 0
            
            for i in 0..<numberSections {
                
                let numberSectionItems = dataSource.collectionView(self, numberOfItemsInSection: i)
                numberItems += numberSectionItems
            }
            
            // Set the invisibleScrollView contentSize width based on number of items
            let contentWidth = invisibleScrollView.frame.width// invisibleScrollView.frame.width * CGFloat(numberItems)
            let contentHeight = toastItemSize.height * CGFloat(numberItems)
            invisibleScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        }
    }
    
    // MARK: - Properties (Private)
    fileprivate var invisibleScrollView: UIScrollView!
    fileprivate var invisibleWidthConstraint: NSLayoutConstraint?
    fileprivate var invisibleLeftConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
        // MARK: - Overrides
    
    override open func scrollRectToVisible(_ rect: CGRect, animated: Bool) {
        invisibleScrollView.setContentOffset(rect.origin, animated: animated)
    }
    
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addInvisibleScrollView(to: superview)
    }
    
    // MARK: - Public API
    
    /*
     This method should ALWAYS be called from the ScalingCarousel delegate when
     the UIScrollViewDelegate scrollViewDidScroll(_:) method is called
     
     e.g In the ScalingCarousel delegate, implement:
     
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
     carousel.didScroll()
     }
     */
    public func didScroll() {
        scrollViewDidScroll(self)
    }

}

private typealias PrivateAPI = CarouselView
fileprivate extension PrivateAPI {
    
    fileprivate func addInvisibleScrollView(to superview: UIView?) {
        guard let superview = superview else { return }
        
        /// Add our 'invisible' scrollview
        invisibleScrollView = UIScrollView(frame: bounds)
        invisibleScrollView.translatesAutoresizingMaskIntoConstraints = false
        invisibleScrollView.isPagingEnabled = true
        invisibleScrollView.showsHorizontalScrollIndicator = false
        
        /*
         Disable user interaction on the 'invisible' scrollview,
         This means touch events will fall through to the underlying UICollectionView
         */
        invisibleScrollView.isUserInteractionEnabled = false
        
        /// Set the scroll delegate to be the ScalingCarouselView
        invisibleScrollView.delegate = self
        
        /*
         Now add the invisible scrollview's pan
         gesture recognizer to the ScalingCarouselView
         */
        addGestureRecognizer(invisibleScrollView.panGestureRecognizer)
        
        /*
         Finally, add the 'invisible' scrollview as a subview
         of the ScalingCarousel's superview
         */
        superview.addSubview(invisibleScrollView)
        
        /*
         Add constraints for height and top, relative to the
         ScalingCarouselView
         */
        invisibleScrollView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        invisibleScrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        /*
         Further configure our layout and add more constraints
         for width and left position
         */
        configureLayout()
    }
    
    fileprivate func configureLayout() {
        
        // Create a ScalingCarouselLayout using our inset
        collectionViewLayout = CarousalLayout(
            withCarouselInset: 0)
        
        /*
         Only continue if we have a reference to
         our 'invisible' UIScrollView
         */
        guard let invisibleScrollView = invisibleScrollView else { return }
        
        // Remove constraints if they already exist
        invisibleWidthConstraint?.isActive = false
        invisibleLeftConstraint?.isActive = false
        
        /*
         Add constrants for width and left postion
         to our 'invisible' UIScrollView
         */
        invisibleWidthConstraint = invisibleScrollView.widthAnchor.constraint(
            equalTo: widthAnchor, constant: -(2 * 0))
        invisibleLeftConstraint =  invisibleScrollView.leftAnchor.constraint(
            equalTo: leftAnchor, constant: 0)
        
        // Activate the constraints
        invisibleWidthConstraint?.isActive = true
        invisibleLeftConstraint?.isActive = true
        
    }
}

/*
 Scroll view delegate extension used to respond to scrolling of the invisible scrollView
 */
private typealias ScrollDelegate = CarouselView
extension ScrollDelegate: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /*
         Move the ScalingCarousel based on the
         contentOffset of the 'invisible' UIScrollView
         */
        updateOffSet()
        
        // Also, this is where we scale our cells
        for cell in visibleCells {
            if let infoCardCell = cell as? ToastItemCollectionViewCell {
//                print("View frame -- \(cell.frame) and \(self.indexPath(for: cell)) and contenOffSet(\(scrollView.contentOffset)")
                infoCardCell.scale(withCarouselInset: 0, contentOffSet: scrollView.contentOffset.y, scale: getScale(offSet: scrollView.contentOffset.y, cellY: cell.frame.origin.y))
                
            }
        }
    }
    
    private func updateOffSet() {
        contentOffset = invisibleScrollView.contentOffset
    }
}


