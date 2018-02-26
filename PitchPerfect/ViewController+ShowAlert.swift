//
//  ViewController+ShowAlert.swift
//  PitchPerfect
//
//  Created by Sergio Costa on 25/02/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
