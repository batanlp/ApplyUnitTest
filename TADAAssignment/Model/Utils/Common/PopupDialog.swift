//
//  PopupDialog.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit

class PopupDialog: NSObject {
    
    static let shared = PopupDialog()
    override init() {
    }
    
    func showPopupDialog(vc: UIViewController, msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
