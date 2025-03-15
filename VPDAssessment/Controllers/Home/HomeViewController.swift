//
//  ViewController.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/15/25.
//

import UIKit

class HomeViewController: UIViewController {
    let repositoryViewModel = RepositoryViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        return tableView
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    let errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindData()
    }
}
