//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Abhishek on 10/10/23.
//

import UIKit
class CharacterDetailsViewController: UICollectionViewController{
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.collectionView.backgroundColor = .red
    }
}
