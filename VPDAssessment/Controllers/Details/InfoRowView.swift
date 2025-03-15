//
//  InfoRowView.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/17/25.
//

import UIKit

class InfoRowView: UIStackView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    init(icon: UIImage?, text: String) {
        super.init(frame: .zero)
        axis = .horizontal
        alignment = .center
        spacing = 8
        translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.image = icon
        infoLabel.text = text
        
        addArrangedSubview(iconImageView)
        addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateText(_ text: String) {
        if text.isEmpty {
            iconImageView.isHidden = true
            infoLabel.isHidden = true
            return
        }
        
        infoLabel.text = text
    }
}
