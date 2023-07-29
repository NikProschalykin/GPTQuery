//
//  IdicatorFooter.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 22.06.2023.
//

import UIKit

final class IdicatorFooter: UICollectionReusableView {
    
    let activityIndicator = UIActivityIndicatorView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IdicatorFooter {
    private func configure() {
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.style = .large
        addViews()
        layoutViews()
    }
    
    private func addViews() {
        addSubview(activityIndicator)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
