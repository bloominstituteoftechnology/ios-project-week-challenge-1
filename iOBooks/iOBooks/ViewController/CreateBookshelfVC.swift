//
//  CreateBookshelfVC.swift
//  iOBooks
//
//  Created by Nikita Thomas on 10/29/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class CreateBookshelfVC: UIViewController {
    
    @IBOutlet weak var createBookTextField: UITextField!
    
    @IBAction func createButton(_ sender: Any) {
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
