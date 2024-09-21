//
//  Cell.swift
//  RickAndMorty
//
//  Created by Alexey Lim on 21/9/24.
//

import UIKit
import Kingfisher

class Cell: UITableViewCell {
    static let reuseIdentifier = "Cell"
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    // No need for imageCache anymore since Kingfisher handles it
    // private let imageCache = NSCache<NSString, UIImage>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(characterImage)
        contentView.addSubview(name)
        
        NSLayoutConstraint.activate([
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            characterImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            characterImage.widthAnchor.constraint(equalToConstant: 50),
            characterImage.heightAnchor.constraint(equalToConstant: 50),
            
            name.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 10),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with character: Character) {
        name.text = character.name

        guard let url = URL(string: character.image) else { return }
        characterImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.25))])
    }
}
