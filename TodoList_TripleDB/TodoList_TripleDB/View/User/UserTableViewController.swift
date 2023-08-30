//
//  UserTableViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    @IBOutlet var tvShareTodoList: UITableView!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    
    
    var receivedId: String = ""
    var todoList: [TodoList_MySQL] = []
    var todoListSQLite: [TodoList_SQLite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myIndicator.startAnimating()
        myIndicator.isHidden = false
        
        let queryModel = TodoListDB_MYSQL()
        queryModel.delegate = self
        queryModel.selectAllDB(receivedId)
        
        let sqlQueryModel = TodoListDB_SQLITE()
        sqlQueryModel.delegate = self
        sqlQueryModel.selectIDDB(id: receivedId)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadShareValues()
    }
    
    func reloadShareValues(){
        let queryModel = TodoListDB_MYSQL()
        queryModel.delegate = self
        queryModel.selectAllDB(receivedId)
        
        let sqlQueryModel = TodoListDB_SQLITE()
        sqlQueryModel.delegate = self
        sqlQueryModel.selectIDShareDB(id: receivedId, isshare: "1")
        tvShareTodoList.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
            let cell = sender as! UserTableViewCell
            let indexPath = tvShareTodoList.indexPath(for: cell)
            
            let detailView = segue.destination as! UserDetailViewController
            detailView.receivedDetailData = todoListSQLite[indexPath!.row]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoListSQLite.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)

        // Configure the cell...
        var context = cell.defaultContentConfiguration()
        context.image = UIImage(data: todoListSQLite[indexPath.row].image)
        context.text = todoListSQLite[indexPath.row].title
        cell.contentConfiguration = context
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

extension UserTableViewController: QueryModelTodoListMySQLProtocol{
    func downloadItem(items: [TodoList_MySQL]) {
        self.todoList = items
        self.tvShareTodoList.reloadData()
        myIndicator.stopAnimating()
        myIndicator.isHidden = true
    }
    
}

extension UserTableViewController: QueryModelSQLiteProtocol{
    func downloadItem(items: [TodoList_SQLite]) {
        self.todoListSQLite = items
        self.tvShareTodoList.reloadData()
        myIndicator.stopAnimating()
        myIndicator.isHidden = true
    }

}
