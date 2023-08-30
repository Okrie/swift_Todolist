//
//  AlertModule.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/28.
//

import Foundation
import UIKit

protocol AlertModuleProtocol{
    func viewAlertFunc()
}

class AlertModule: UIViewController{
    var alerttitle: String = ""
    var alertcontent: String = ""
    
    var delegate: AlertModuleProtocol!
    
    func viewAlert(){
        let viewAlert = UIAlertController(title: self.alerttitle, message: self.alertcontent, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        viewAlert.addAction(okAction)
        
        present(viewAlert, animated: true)
    }
}
