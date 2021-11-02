//
//  EntryViewController.swift
//  APP2
//
//  Created by شروق فرج سويلم الحويطي on 26/03/1443 AH.
//

import UIKit

class EntryViewController: UIViewController , UITextFieldDelegate {
    @IBOutlet var field: UITextField!
    
    var list: List!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask(){
        guard let text = field.text, !text.isEmpty else {
            return
        }
        list.items.append(Task(title: text))
        if let  count = (UserDefaults().value(forKey: "count") as? Int) {
            
            let newCount = count + 1
            UserDefaults().set(newCount, forKey: "count")
            UserDefaults().set(text, forKey: "task_\(newCount)")
            
            navigationController?.popViewController(animated: true)
        }
}
}
