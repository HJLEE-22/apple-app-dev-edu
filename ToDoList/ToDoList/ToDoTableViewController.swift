//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by 이형주 on 2022/07/14.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {

    var todos = [ToDo]()
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveTodos(todos)
        }
    }
    
    @IBAction func unwindToToDoList(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "saveUnwind" else { return }
        let sourceViewController = unwindSegue.source as! ToDoDetailTableViewController
        if let todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveTodos(todos)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath) as? ToDoCell else { fatalError("Could not deque a cell") }
        let todo = todos[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        let checkedImage = UIImage(named: "Checked")
        let uncheckedImage = UIImage(named: "Unchecked")
        cell.isCompleteButton.setImage(checkedImage, for: .selected)
        cell.isCompleteButton.setImage(uncheckedImage, for: .normal)

        cell.delegate = self
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveTodos(todos)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
  // MARK: - Navigation

    // 편집 모드로 전환할 때 기존 셀의 데이터를 디테일뷰로 넘기기 위한 프리페어.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "EditToDo",
           let navController = segue.destination as? UINavigationController,
           let todoDetailTableViewController = navController.topViewController as? ToDoDetailTableViewController {
            let indexPath = tableView.indexPathForSelectedRow
            let selectedToDo = todos[indexPath!.row]
            todoDetailTableViewController.todo = selectedToDo
        }
    }
    

    
 
}
