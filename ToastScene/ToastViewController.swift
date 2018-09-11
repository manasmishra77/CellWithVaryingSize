//
//  ToastViewController.swift
//  ToastScene
//
//  Created by Manas Mishra on 09/09/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

class ToastViewController: UIViewController {

    @IBOutlet weak var carouselCollectionView: CarouselView!
    @IBOutlet weak var backGroundGIFImageView: UIImageView!
    
    let toastViewModel = ToastViewModel()
    var newMessageView: NewMessageView?
    var deleteMessageView: DeleteMessageView?
    var selectedCell = 0
    
    @IBOutlet weak var addNewMsgBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.c
        carouselCollectionView.register(UINib(nibName: ToastItemCellIdentifier, bundle: nil), forCellWithReuseIdentifier: ToastItemCellIdentifier)
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        let image = UIImage.gifImageWithName(name: BackgroundGifImageName)
        backGroundGIFImageView.image = image
        
    }
    
    @IBAction func addNewMsgBtnPressed(_ sender: Any) {
        newMessageView = (Bundle.main.loadNibNamed("NewMessageView", owner: self, options: nil)?.last as! NewMessageView)
        self.view.addSubview(newMessageView!)
        newMessageView?.frame = addNewMsgBtn.frame
        UIView.animate(withDuration: 0.4, animations: {
            self.carouselCollectionView.alpha = 0
            self.addNewMsgBtn.alpha = 0
            self.newMessageView?.frame = CGRect.init(x: 20, y: 20, width: screenWidth - 40, height: screenHeight - 40)
            self.newMessageView?.delegate = self
        }) { (onComplete) in
            self.newMessageView?.textView.becomeFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollCellToMiddle(indexPath: IndexPath, cell: ToastItemCollectionViewCell) {
        let cellArray = self.carouselCollectionView.visibleCells as? [ToastItemCollectionViewCell]
        deleteMessageView = (Bundle.main.loadNibNamed("DeleteMessageView", owner: self, options: nil)?.last as! DeleteMessageView)
        let actualY = cell.frame.origin.y - self.carouselCollectionView.getInvisibleCollectionViewContent().y
        deleteMessageView?.frame = CGRect.init(x: cell.frame.height/2, y: actualY+cell.frame.height/2, width: 300, height: 150)
        deleteMessageView?.msgLabel.alpha = 0
        self.deleteMessageView?.deleteBtn.alpha = 0.0
        self.deleteMessageView?.crossBtn.alpha = 0.0
        deleteMessageView?.msgLabel.text = toastViewModel.toastModels[indexPath.row]
        self.view.addSubview(deleteMessageView!)
        self.deleteMessageView?.delegate = self
        UIView.animate(withDuration: 0.4, animations: {
            self.deleteMessageView?.frame = CGRect.init(x: 20, y: 20, width: screenWidth - 40, height: screenHeight - 40)
            self.deleteMessageView?.msgLabel.alpha = 1
            self.carouselCollectionView.alpha = 0.0
            self.addNewMsgBtn.alpha = 0
        }) { (boolValue) in
            self.deleteMessageView?.deleteBtn.alpha = 1.0
            self.deleteMessageView?.crossBtn.alpha = 1.0
        }
    }
    
    func animateCollcetionViewAppear(alphaValue: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.carouselCollectionView.alpha = alphaValue
            self.addNewMsgBtn.alpha = alphaValue
        }
    }
    

}

extension ToastViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toastViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToastItemCellIdentifier, for: indexPath)
        
        if let cell = cell as? ToastItemCollectionViewCell {
            cell.toastLabel.text = toastViewModel.toastItem(index: indexPath.row)
            if cell.toastLabel.text == "" {
                cell.alpha = 0.0
            } else {
                cell.alpha = 1.0
                cell.setDefaultPositions(cellIndex: indexPath.row)
            }
        }
        
        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
}


extension ToastViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (toastViewModel.toastModels[indexPath.row] == "") {
            return
        }
        selectedCell = indexPath.row
        self.scrollCellToMiddle(indexPath: indexPath, cell: collectionView.cellForItem(at: indexPath) as! ToastItemCollectionViewCell)
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



extension ToastViewController: NewMessageViewDelegate {
    func addObjectToArray(dataString: String) {
        self.toastViewModel.toastModels.insert(dataString, at: self.toastViewModel.toastModels.count - 1)
        newMessageView?.delegate = nil
        newMessageView = nil
        DispatchQueue.main.async {
            self.carouselCollectionView.reloadCarousalViewOnAdd()
        }
        self.animateCollcetionViewAppear(alphaValue: 1.0)
    }
    
    func cancelBtnPressed() {
        self.animateCollcetionViewAppear(alphaValue: 1.0)
    }
}

extension ToastViewController: DeleteMessageViewDelegate {
    func deleteMessage() {
        toastViewModel.toastModels.remove(at: self.selectedCell)
        DispatchQueue.main.async {
            self.carouselCollectionView.reloadCarousalViewOnDelete()
            self.crossBtnPressed()
        }
    }
    
    func crossBtnPressed() {
        self.animateCollcetionViewAppear(alphaValue: 1.0)
        deleteMessageView?.delegate = nil
        deleteMessageView = nil
    }
    
}
