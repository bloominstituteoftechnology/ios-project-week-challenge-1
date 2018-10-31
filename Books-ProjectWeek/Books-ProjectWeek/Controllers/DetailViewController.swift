//
//  DetailViewController.swift
//  Books-ProjectWeek
//
//  Created by Yvette Zhukovsky on 10/29/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    var newBook: Volume?{
        didSet{
            if let book = newBook {
                RealFirebase().storeBooks(volume: book, completion: {
                    NSLog("\($0)") })
            }
            
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let nb = newBook else {return}
        bookName.text = nb.volumeInfo.title
        nb.volumeInfo.imageLinks.thumbnailImage {
            image in
            DispatchQueue.main.async {
                self.bookImage?.image = image
            }
        }
        author.text = nb.volumeInfo.authors?.joined(separator:" , ")
        descriptionBook.text = nb.volumeInfo.description
        RealFirebase().isRead(id:nb.id) {
            (rb:ReadBook?, error: Error? ) in
            if let error = error {
                NSLog("is read error \(error)")
                return
            }
            guard let rb = rb else {return}
            DispatchQueue.main.async {
                self.isRead.isOn = rb.read
                
            }
        }
    }
    
    
    @IBOutlet weak var descriptionBook: UITextView!
    
    
    @IBOutlet weak var bookName: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBOutlet weak var isRead: UISwitch!
    
    @IBAction func read(_ sender: UISwitch) {
        RealFirebase().markRead(id:(self.newBook?.id)!, read: sender.isOn) {
            NSLog("switch broken \($0)")
        }
        
    }
    
    
    
    @IBOutlet weak var booksPicker: UIPickerView!
    
    
    
    
    @IBAction func addToShelf(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "Add Book", message: "Please enter Book name", preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //cancel code
        }
        alertController.addAction(cancelAction)
        
        //Create an optional action
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .default) { action -> Void in
            let text = (alertController.textFields?.first)?.text
            RealFirebase().addBookToShelf(name: text!, id: (self.newBook?.id)!) {
                NSLog("createShelf: \($0)")
            }
        }
        alertController.addAction(nextAction)
        
        //Add text field
        alertController.addTextField(configurationHandler: {(_) in })
        
        //Present the AlertController
        present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    
}
