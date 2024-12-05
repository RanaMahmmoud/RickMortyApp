//
//  CharacterTableViewCell.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import UIKit
import SwiftUI

class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterCell"
    
    private var hostingController: UIHostingController<CharacterRowView>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .default
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.separatorInset = .zero
        self.layoutMargins = .zero
        self.preservesSuperviewLayoutMargins = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with character: CharacterModel) {
        hostingController?.view.removeFromSuperview()
        hostingController = UIHostingController(rootView: CharacterRowView(character: character))
        
        if let hostingView = hostingController?.view {
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(hostingView)
            
            NSLayoutConstraint.activate([
                hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
}
