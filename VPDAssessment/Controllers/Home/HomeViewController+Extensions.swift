//
//  HomeViewController+Extensions.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/16/25.
//

import UIKit
import Kingfisher

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryViewModel.getPaginatedData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let repo = repositoryViewModel.getPaginatedData()[indexPath.row]
        
        let imageUrl = repo.owner?.avatarURL ?? ""
        let name = repo.name?.capitalized
        cell.configure(with: imageUrl ,name: name )
        
        // Load more data when reaching the bottom
        if indexPath.row == repositoryViewModel.getPaginatedData().count - 1 {
            loadMoreRepositories()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        let detailViewModel = detailsVC.detailViewModel
        detailViewModel.username = repositoryViewModel.repositoriesData[indexPath.row].owner?.login
        detailsVC.reloadInputViews()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        title = "Repositories"
        
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
        
        // Configure TableView
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        repositoryViewModel.fetchRepositories()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black, // Change to desired color
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black, // Change to desired color
            .font: UIFont.systemFont(ofSize: 32, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = appearance.titleTextAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = appearance.largeTitleTextAttributes
        
        // Set constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            errorView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func loadMoreRepositories() {
        guard repositoryViewModel.hasMoreData, !repositoryViewModel.isLoadingMoreData else {
            tableView.tableFooterView = nil
            return
        }
        
        spinner.startAnimating()
        tableView.tableFooterView = createFooterView()
        
        repositoryViewModel.loadMoreData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                if !self.repositoryViewModel.hasMoreData {
                    self.tableView.tableFooterView = nil
                }
            }
        }
    }
    
    
    @objc func refreshData() {
        fetchRepositories()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.refreshControl.endRefreshing()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideLoading()
        }
    }
    
    private func fetchRepositories() {
        showLoading()
        repositoryViewModel.fetchRepositories()
    }
    
    @objc private func retryFetchingData() {
        errorView.hideError()
        fetchRepositories()
    }
    private func showLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
        errorView.isHidden = true
    }
    
    private func hideLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    func bindData() {
        repositoryViewModel.onDataChange = { [weak self] in
            self?.hideLoading()
            self?.tableView.reloadData()
        }
        
        repositoryViewModel.onErrorChange = { [weak self] error in
            DispatchQueue.main.async {
                self?.hideLoading()
                self?.errorView.showError(message: error.localizedDescription, retryAction: {
                    self?.retryFetchingData()
                })
            }
            print(error.localizedDescription)
        }
    }
    
    private func createFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
        ])
        
        return footerView
    }
    
}
