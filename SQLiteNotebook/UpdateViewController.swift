//
//  UpdateViewController.swift
//  SQLiteNotebook
//
//  Created by Jaco Grinwis on 23-09-17.
//  Copyright © 2017 Jaco Grinwis. All rights reserved.
//

import Cocoa

class UpdateViewController: NSViewController {

    @IBOutlet weak var idTextField: NSTextField!
    @IBOutlet weak var nameTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        print("UPDATE CLICKED")
        let userInfo = ["id": idTextField.stringValue, "name": nameTextField.stringValue]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateNote"), object: nil, userInfo: userInfo)
        self.dismiss(self)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        print("CANCEL CLICKED")
        self.dismiss(self)
    }
    
}
