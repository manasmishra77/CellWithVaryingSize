//
//  NewMessageView.swift
//  ToastScene
//
//  Created by Vinit Somani on 9/9/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

protocol NewMessageViewDelegate {
    func addObjectToArray(dataString: String)
    func cancelBtnPressed()
}

class NewMessageView: UIView {


    @IBOutlet weak var textView: UITextView!
    var delegate: NewMessageViewDelegate?
    
    override func awakeFromNib() {
        textView.delegate = self
    }
    
    @IBOutlet weak var DoneBtn: UIButton!
    @IBAction func doneBtnPressed(_ sender: Any) {
        delegate?.addObjectToArray(dataString: textView.text)
        self.textView.endEditing(true)
        self.removeFromSuperview()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.textView.endEditing(true)
        self.removeFromSuperview()
        delegate?.cancelBtnPressed()
    }
    
    func startEditing() {
        textView.becomeFirstResponder()
    }

}

extension NewMessageView: UITextViewDelegate {
    
}
