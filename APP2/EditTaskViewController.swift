//
//  TaskViewController.swift
//  APP2
//
//  Created by شروق فرج سويلم الحويطي on 26/03/1443 AH.
//

import UIKit


class EditTaskViewController: UIViewController {
    @IBOutlet weak var taskField: UITextField!
    
    var list:List!
    var selectedTaskIndex: Int!
    override func viewWillAppear(_ animated: Bool) {
        print(list.items[selectedTaskIndex])
        taskField.text = list.items[selectedTaskIndex].title
    }
    @IBAction func updateButton(_ sender: Any) {
        list.items[selectedTaskIndex].title = taskField.text!
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

