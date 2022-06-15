//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by 이형주 on 2022/06/10.
//

import UIKit

class EmojiTableViewController: UITableViewController {


    
    var emojis: [Emoji] = [
    Emoji(symbol: "😀", name: "Grinning Face", description: "A typical simley face.", usage: "happiness"),
    Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face", usage: "unsure what to think, displeasure"),
    Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes", usage: "love of something; attractive"),
    Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge", usage: "person of authority"),
    Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle", usage: "Something slow"),
    Emoji(symbol: "🐘", name: "Elephant", description: "A grey elephant", usage: "Good memory"),
    Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti", usage: "spaghetti"),
    Emoji(symbol: "🎲", name: "Die", description: "A single die", usage: "taking a risk, chance; game")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.emojis.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EmojiTableViewCell
        let emoji = emojis[indexPath.row]
        cell.update(with: emoji)
//        cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
//        cell.detailTextLabel?.text = emoji.description
        cell.showsReorderControl = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(moveEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoji" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let emoji = emojis[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditEmojiTableViewContoller = navController.topViewController as! AddEditEmojiTableTableViewController
            
            addEditEmojiTableViewContoller.emoji = emoji
        }
    }
    
    @IBAction func unwindToEmojiTableView(_ unwindSegue: UIStoryboardSegue) {
        
        guard unwindSegue.identifier == "saveUnwind",
        let sourceViewController = unwindSegue.source as? AddEditEmojiTableTableViewController,
              let emoji = sourceViewController.emoji else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }

        
    }
    
}

