//
//  DetailsViewController+Extensions.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/17/25.
//

import UIKit

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        title = "User Details"
        
        showLoading()
        tableView.delegate = self
        tableView.dataSource = self
        detailViewModel.fetchUserDetails()
//        detailViewModel.fetchUserRepo()
        
        view.addSubview(detailView)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.heightAnchor.constraint(equalToConstant: 400),
            
            tableView.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            errorView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func bindData() {
        detailViewModel.onDataChange = { [weak self] in
            self?.detailView.configure(with:self?.detailViewModel.detailsData.avatarURL , name: self?.detailViewModel.detailsData.name, subtitle: self?.detailViewModel.detailsData.login, location:self?.detailViewModel.detailsData.location, website: self?.detailViewModel.detailsData.blog, twitter: self?.detailViewModel.detailsData.twitterUsername,  followersCount: self?.detailViewModel.detailsData.followers, followingCount: self?.detailViewModel.detailsData.following)
            
            self?.tableView.reloadData()
            self?.hideLoading()
        }
        
        detailViewModel.onErrorChange = { [weak self] error in
            DispatchQueue.main.async {
                self?.hideLoading()
                self?.errorView.showError(message: error.localizedDescription, retryAction: {
                    self?.showLoading()
                    self?.detailViewModel.fetchUserDetails()
                })
                self?.tableView.isHidden = true
                self?.detailView.isHidden = true
            }
            print(error.localizedDescription)
            self?.hideLoading()
        }
    }
    
    private func showLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
        errorView.isHidden = true
        detailView.isHidden = true
    }
    
    private func hideLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        detailView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.reposData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let name = detailViewModel.reposData[indexPath.row]
        cell.textLabel?.text = name.name?.capitalized
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        
        let label = UILabel()
        label.text = "Repos"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
