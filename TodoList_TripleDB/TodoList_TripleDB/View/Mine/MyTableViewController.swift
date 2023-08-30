//
//  MyTableViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    @IBOutlet var tvListView: UITableView!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    
//    var todoList: [TodoList_MySQL] = []
    var todoList: [TodoList_SQLite] = []
//    let queryModel = TodoListDB_MYSQL()
    let sqlQueryModel = TodoListDB_SQLITE()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myIndicator.startAnimating()
        myIndicator.isHidden = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
            let cell = sender as! MyTableViewCell
            let indexPath = tvListView.indexPath(for: cell)
            
            let detailView = segue.destination as! MyDetailViewController
            detailView.receiveData = todoList[indexPath!.row]

//            let url: URL = URL(string: todoList[indexPath!.row].imagename)!
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    detailView.imgView.image = UIImage(data: data!)
//                }
//            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadValues()
    }
    
    func reloadValues(){
//        queryModel.delegate = self
//        queryModel.selectAllDB(Message.id)
        sqlQueryModel.delegate = self
        sqlQueryModel.selectIDDB(id: Message.id)
        tvListView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        var content = cell.defaultContentConfiguration()
//        let url = URL(string: todoList[indexPath.row].imagename)
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                content.image = UIImage(data: data!)
//            }
//        }
        content.text = todoList[indexPath.row].title
        content.image = UIImage(data: todoList[indexPath.row].image)
        
        cell.contentConfiguration = content
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension MyTableViewController: QueryModelTodoListMySQLProtocol{
//    func downloadItem(items: [TodoList_MySQL]) {
//        self.todoList = items
//        self.tvListView.reloadData()
//    }
//}

extension MyTableViewController: QueryModelSQLiteProtocol{
    func downloadItem(items: [TodoList_SQLite]) {
        self.todoList = items
        self.tvListView.reloadData()
        myIndicator.stopAnimating()
        myIndicator.isHidden = true
        
    }
}
