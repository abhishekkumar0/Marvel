//
//  FilterCell.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import UIKit
class FilterCell: UICollectionViewCell{
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.fontWith(name: .Poppins, fontFace: .Regular, size: 15)
        label.textColor = UIColor.colorFromHexString("313140")
        return label
    }()
    
    var filter: Filter?{
        didSet{
            self.label.text = self.filter?.label
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

extension FilterCell{
    
    private func configureView(){
        self.modifyLayouts()
        self.setUpConstraints()
    }
    
    private func modifyLayouts(){
        self.contentView.addSubview(label)
        self.contentView.backgroundColor = .white
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            
        ])
    }
    
}
