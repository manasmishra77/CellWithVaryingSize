//
//  DeleteMessageView.swift
//  ToastScene
//
//  Created by Vinit Somani on 9/9/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

protocol DeleteMessageViewDelegate {
    func deleteMessage()
    func crossBtnPressed()
}

class DeleteMessageView: UIView {

    @IBOutlet weak var firstLetter: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var msgLabel: UILabel!
    var delegate: DeleteMessageViewDelegate?
    
    @IBAction func crossBtnPressed(_ sender: Any) {
        delegate?.crossBtnPressed()
        self.removeFromSuperview()
    }
    
    @IBAction func deleteMsgPressed(_ sender: Any) {
     self.removeFromSuperview()
     delegate?.deleteMessage()
    }
}
