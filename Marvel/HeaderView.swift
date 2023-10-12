//
//  HeaderView.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import UIKit
class HeaderView: UICollectionReusableView{
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        self.addSubview(label)
//        self.configureLabel()
        self.setUpConstraints()
        
    }

    public func configureLabel(with title: NSMutableAttributedString){
        self.label.attributedText = title
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 20),
        ])
    }
    
}
