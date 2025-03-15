//
//  DetailsView.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/17/25.
//

import UIKit
import Kingfisher

class DetailsView: UIScrollView {
    
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Info Rows for Location, Website, Twitter
    private let locationRow = InfoRowView(icon: UIImage(systemName: "mappin.and.ellipse"), text: "")
    private let websiteRow = InfoRowView(icon: UIImage(systemName: "link"), text: "")
    private let twitterRow = InfoRowView(icon: UIImage(systemName: "bird.circle"), text: "")
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let followsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        //        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(subtitleLabel)
        
        mainStackView.addArrangedSubview(avatarImageView)
        mainStackView.addArrangedSubview(nameStackView)
        
        // Add info rows to the vertical stack
        infoStackView.addArrangedSubview(locationRow)
        infoStackView.addArrangedSubview(websiteRow)
        infoStackView.addArrangedSubview(twitterRow)
        
        followsStackView.addArrangedSubview(followersLabel)
        followsStackView.addArrangedSubview(followingLabel)
        
        contentView.addSubview(mainStackView)
        contentView.addSubview(infoStackView)
        contentView.addSubview(followsStackView)
        addSubview(contentView)
        
        // Constraints
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            infoStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            
            followsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            followsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            followsStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20),
        ])
    }
    
    func configure(with imageUrl: String?, name: String?, subtitle: String?, location: String?, website: String?, twitter: String?, followersCount: Int?, followingCount: Int?) {
        if let url = URL(string: imageUrl ?? "") {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle"))
        }
        nameLabel.text = name ?? "Unknown"
        subtitleLabel.text = subtitle ?? ""
        
        locationRow.updateText(location ?? "")
        websiteRow.updateText(website ?? "")
        twitterRow.updateText(twitter ?? "" )
        
        followersLabel.text = "\(followersCount ?? 0) Followers"
        followingLabel.text = "\(followingCount ?? 0) Following"
        
    }
}
