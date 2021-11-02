//
//  ViewController.swift
//  APP2
//
//  Created by شروق فرج سويلم الحويطي on 26/03/1443 AH.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var list = List()
    var selectedCell : Int!

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        // Git all current saved tasks
        updateTasks()
    }
    
    func updateTasks(){
        list.items.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
        return
        }
        for x in 0..<count {
            if let  task = UserDefaults().value(forKey: "task_\(x+1)") as? Task {
                list.items.append(task)
                
            }
        }
        tableView.reloadData()
    }
    
    
    @IBAction func didTapAdd(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "NewTask"
        vc.list = list
        
        navigationController?.pushViewController(vc, animated:true )
    }
    
    
}
extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("user select cell: \(indexPath.row)")
        self.selectedCell = indexPath.row
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! EditTaskViewController
        vc.title = "NewTask"
        vc.list = list
        vc.selectedTaskIndex = selectedCell
        navigationController?.pushViewController(vc, animated:true )
    }
}
extension  ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list.items[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            list.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}


