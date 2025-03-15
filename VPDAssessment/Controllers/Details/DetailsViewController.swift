//
//  DetailsViewController.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/17/25.
//

import UIKit

class DetailsViewController: UIViewController {
    let detailViewModel = DetailsViewModel()
    
    let detailView = DetailsView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
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
