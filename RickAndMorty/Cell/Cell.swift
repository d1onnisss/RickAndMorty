//
//  Cell.swift
//  RickAndMorty
//
//  Created by Alexey Lim on 21/9/24.
//

import Foundation
import UIKit

import UIKit

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
    
    private let imageCache = NSCache<NSString, UIImage>()
    
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
        if let cachedImage = imageCache.object(forKey: NSString(string: character.image)) {
            characterImage.image = cachedImage
        } else {
            loadImage(from: character.image)
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.imageCache.setObject(image, forKey: NSString(string: urlString))
                    self?.characterImage.image = image
                }
            }
        }
    }
}
