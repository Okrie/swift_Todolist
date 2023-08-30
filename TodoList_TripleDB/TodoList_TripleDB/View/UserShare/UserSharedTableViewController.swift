//
//  UserSharedTableViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class UserSharedTableViewController: UITableViewController {

    @IBOutlet var tvShareUserListView: UITableView!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    
    var userList: [ShareUserJSON] = []
    var queryModel = UserDataDB_MySQL()
    
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
        let cell = sender as! UserSharedTableViewCell
        let indexPath = tvShareUserListView.indexPath(for: cell)
        
        if segue.identifier == "sgShareUserDetail"{
            let detailView = segue.destination as! UserTableViewController
            
            detailView.receivedId = userList[indexPath!.row].userid
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadValues()
    }
    
    func reloadValues(){
        queryModel.delegate = self
        queryModel.shareUser()
        tvShareUserListView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfo", for: indexPath)

        // Configure the cell...
        var context = cell.defaultContentConfiguration()
        context.text = "\(userList[indexPath.row].userid)'s TodoList"
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

extension UserSharedTableViewController: QueryModelUserDataMySQLProtocol{
    func shareUserList(items: [ShareUserJSON]) {
        self.userList = items
        myIndicator.stopAnimating()
        myIndicator.isHidden = true
        self.tvShareUserListView.reloadData()
    }
    
    func loginUserList(count: Int) {
        //
    }
    
    func dupliUserList(count: Int) {
        //
    }
    
    
}
