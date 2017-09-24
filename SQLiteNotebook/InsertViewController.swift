//
//  InsertViewController.swift
//  SQLiteNotebook
//
//  Created by Jaco Grinwis on 23-09-17.
//  Copyright © 2017 Jaco Grinwis. All rights reserved.
//

import Cocoa

class InsertViewController: NSViewController {

    @IBOutlet weak var nameTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        print("INSERT CLICKED")
        let userInfo = ["name": nameTextField.stringValue]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newNote"), object: nil, userInfo: userInfo)
        self.dismiss(self)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        print("CANCEL CLICKED")
        self.dismiss(self)
    }
}
