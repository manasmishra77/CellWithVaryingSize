//
//  ToastViewController.swift
//  ToastScene
//
//  Created by Manas Mishra on 09/09/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

class ToastViewController: UIViewController {

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    let toastViewModel = ToastViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.c
        carouselCollectionView.register(UINib(nibName: ToastItemCellIdentifier, bundle: nil), forCellWithReuseIdentifier: ToastItemCellIdentifier)
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

extension ToastViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toastViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToastItemCellIdentifier, for: indexPath)
        
        if let cell = cell as? ToastItemCollectionViewCell {
            cell.mainView.backgroundColor = toastMainViewBackgroundColor
            cell.toastLabel.text = toastViewModel.toastItem(index: indexPath.row)
        }
        
        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
}


extension ToastViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
