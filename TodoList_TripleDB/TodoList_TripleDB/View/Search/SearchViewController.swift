//
//  SearchViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tvSearchList: UITableView!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    
    var todoListSearch: [TodoList_SQLite] = []
    var isFiltering: Bool = false
    var filtered: [TodoList_SQLite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myIndicator.startAnimating()
        myIndicator.isHidden = false

        // Do any additional setup after loading the view.
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        tvSearchList.delegate = self
        tvSearchList.dataSource = self
        
        let queryModel = TodoListDB_SQLITE()
        queryModel.delegate = self
        queryModel.selectIDDB(id: Message.id)

        let mysqlQueryModel = TodoListDB_MYSQL()
        mysqlQueryModel.delegate = self
        mysqlQueryModel.selectAllDB(Message.id)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgSearchDetail"{
            let cell = sender as! SearchTableViewCell
            let indexPath = tvSearchList.indexPath(for: cell)
            let detailView = segue.destination as! MyDetailViewController
            if self.isFiltering{
                detailView.receiveData = self.filtered[indexPath!.row]
            } else{
                detailView.receiveData = self.todoListSearch[indexPath!.row]
            }
        }
    }
    

}

extension SearchViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isFiltering = true
        self.searchBar.showsCancelButton = true
        self.tvSearchList.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTxt = searchBar.text?.lowercased() else {return}

        if searchTxt.isEmpty{
            self.filtered = self.todoListSearch
        } else{
            self.filtered = self.todoListSearch.filter{$0.title.localizedStandardContains(searchTxt)}
        }

        self.tvSearchList.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.isFiltering = false
        self.tvSearchList.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tvSearchList.reloadData()
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filtered.count : self.todoListSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvSearchList.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        
        var content = cell.defaultContentConfiguration()
        if self.isFiltering {
            content.image = UIImage(data: self.filtered[indexPath.row].image)
            content.text = self.filtered[indexPath.row].title
        } else{
            content.image = UIImage(data: self.todoListSearch[indexPath.row].image)
            content.text = self.todoListSearch[indexPath.row].title
        }
        cell.contentConfiguration = content
        
        myIndicator.stopAnimating()
        myIndicator.isHidden = true
        return cell
    }
    
}

extension SearchViewController: QueryModelTodoListMySQLProtocol{
    func downloadItem(items: [TodoList_MySQL]) {
        //
    }
}

extension SearchViewController: QueryModelSQLiteProtocol{
    func downloadItem(items: [TodoList_SQLite]) {
        self.todoListSearch = items
        self.tvSearchList.reloadData()
    }
    
}
