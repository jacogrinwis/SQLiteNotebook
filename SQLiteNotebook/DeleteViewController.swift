//
//  DeleteViewController.swift
//  SQLiteNotebook
//
//  Created by Jaco Grinwis on 23-09-17.
//  Copyright © 2017 Jaco Grinwis. All rights reserved.
//

import Cocoa

class DeleteViewController: NSViewController {

    @IBOutlet weak var idTextField: NSTextField!
    @IBOutlet weak var nameTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        print("DELETE CLICKED")
        let userInfo = ["id": idTextField.stringValue, "name": nameTextField.stringValue]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteNote"), object: nil, userInfo: userInfo)
        self.dismiss(self)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        print("CANCEL CLICKED")
        self.dismiss(self)
    }
    
}
