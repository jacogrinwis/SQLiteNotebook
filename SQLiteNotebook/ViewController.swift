//
//  ViewController.swift
//  SQLiteNotebook
//
//  Created by Jaco Grinwis on 23-09-17.
//  Copyright © 2017 Jaco Grinwis. All rights reserved.
//

import Cocoa
import SQLite

class ViewController: NSViewController {

    var database: Connection!
    
    let notebookTable = Table("notebook")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let createdAt = Expression<Date>("createdAt")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(insertNote(_:)), name: NSNotification.Name("newNote"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNote(_:)), name: NSNotification.Name("updateNote"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote(_:)), name: NSNotification.Name("deleteNote"), object: nil)

        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("notebook").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
        } catch {
            print(error.localizedDescription)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func createTableClicked(_ sender: Any) {
        print("CREATE TABLE CLICKED")
        
        let createTable = self.notebookTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.createdAt)
        }
        
        do {
            try self.database.run(createTable)
            print("CREATED TABLE")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func insertNoteClicked(_ sender: Any) {
        print("INSERT CLICKED")
    }
    
    @IBAction func listNotesClicked(_ sender: Any) {
        print("LIST NOTES CLICKED")
        
        do {
            let notebook = try self.database.prepare(self.notebookTable)
            for note in notebook {
                print("id: \(note[self.id]), name: \(note[self.name]), created at: \(note[self.createdAt])")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func updateNoteClicked(_ sender: Any) {
        print("UPDATE NOTE CLICKED")
    }
    
    @objc func insertNote(_ notification: Notification) {
        print("NOTIFICATION")
        if let name = notification.userInfo?["name"] as? String {
            let createdAt = Date()
            
            let insertNote = self.notebookTable.insert(self.name <- name, self.createdAt <- createdAt)
            
            do {
                try self.database.run(insertNote)
                print("INSERTED NOTE")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func updateNote(_ notification: Notification) {
        print("NOTIFICATION")
        if let name = notification.userInfo?["name"] as? String {
            let noteIdString = notification.userInfo?["id"] as? String
            let noteId = Int(noteIdString!)
            print(noteId!)
            
            let note = self.notebookTable.filter(self.id == noteId!)
            let updateNote = note.update(self.name <- name)
            
            do {
                try self.database.run(updateNote)
                print("UPDATED NOTE")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func deleteNote(_ notification: Notification) {
        print("NOTIFICATION")
        if let name = notification.userInfo?["name"] as? String {
            let noteIdString = notification.userInfo?["id"] as? String
            let noteId = Int(noteIdString!)
            print(noteId!)
            
            let note = self.notebookTable.filter(self.id == noteId!)
            let deleteNote = note.delete()
            
            do {
                try self.database.run(deleteNote)
                print("DELETE NOTE")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

