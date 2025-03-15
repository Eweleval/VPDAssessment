//
//  CustomTableViewCell.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/17/25.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        
        // Set constraints for a fixed size (50x50)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // ImageView Constraints
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // TextField Constraints
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func configure(with imageUrl: String?, name: String?) {
        if let url = URL(string: imageUrl ?? "") {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle"))
        }
        if let name = name {
            nameLabel.text = name
        }
    }
}
