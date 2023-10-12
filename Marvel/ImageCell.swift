//
//  ImageCell.swift
//  Marvel
//
//  Created by Abhishek on 09/10/23.
//

import UIKit
import SDWebImage
import SkeletonView
class ImageCollectionView: UICollectionViewCell{
    
    private lazy var imageView = UIImageView()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Gradient")
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.fontWith(name: .Poppins, fontFace: .SemiBold, size: 12)
        return label
    }()
    
    var characters: Character?{
        didSet{
            self.setCharactersData()
        }
    }
    
    var comics: Comic?{
        didSet{
            self.setComicsData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageCollectionView{
    private func configureView(){
        self.contentView.addSubviews([imageView, backgroundImage, name])
        self.imageView.frame = self.contentView.bounds
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 4
        self.setUpConstraints()
        self.makeSkeleton()
    }
    
    private func makeSkeleton(){
        self.isSkeletonable = true
        self.imageView.isSkeletonable = true
        self.contentView.isSkeletonable = true
        self.name.isSkeletonable = true
        self.backgroundImage.isSkeletonable = true
    }
    
    private func setCharactersData(){
        guard let path = self.characters?.thumbnail.path, let thumbnailExt = self.characters?.thumbnail.thumbnailExtension else {return}
        guard let url = URL(string: path + ".\(thumbnailExt)") else {return}
        self.imageView.sd_setImage(with: url)
        self.name.text = self.characters?.name ?? ""
        self.backgroundImage.isHidden = false
    }
    
    private func setComicsData(){
        guard let path = self.comics?.thumbnail?.path, let thumbnailExt = self.comics?.thumbnail?.extension else {return}
        guard let url = URL(string: path + ".\(thumbnailExt)") else {return}
        self.imageView.sd_setImage(with: url)
        self.name.text = self.comics?.series?.name
        self.backgroundImage.isHidden = false
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            self.name.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8),
            self.name.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor),
            self.name.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.backgroundImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.backgroundImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
        ])
    }
}
