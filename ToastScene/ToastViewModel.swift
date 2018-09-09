//
//  ToastViewModel.swift
//  ToastScene
//
//  Created by Manas Mishra on 09/09/18.
//  Copyright © 2018 manas. All rights reserved.
//

import UIKit

class ToastViewModel: NSObject {
    
    var toastModels: [String] = ["A", "AAAA", "BBBBB", "D", "F", "A", "AAAA", "BBBBB", "D", "F"]
    
    

    var numberOfItems: Int {
        return toastModels.count
    }
    
    func toastItem(index: Int) -> String {
        return toastModels[index]
    }
    
}
