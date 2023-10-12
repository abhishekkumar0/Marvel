//
//  CharactersByNameViewController.swift
//  Marvel
//
//  Created by Abhishek on 12/10/23.
//

import UIKit
import SkeletonView

class CharactersByNameViewController: UICollectionViewController{
    
    private let viewModel = CharactersByNameViewModel()
    var nameStartWith: String
    
    init(nameStartWith: String) {
        self.nameStartWith = nameStartWith
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
}


extension CharactersByNameViewController{
    
    private func configureView(){
        self.configureSkeletonView()
        self.modifyLayouts()
        self.setUpCollectionView()
        let param: [String: Any] = ["limit": self.viewModel.limit, "offset": self.viewModel.offset, "nameStartsWith": nameStartWith]
        self.getCharacters(param: param)
    }
    
    private func modifyLayouts(){
        self.view.backgroundColor = .white
    }
    
    private func updateUI(){
        self.view.hideSkeleton()
        self.collectionView.stopSkeletonAnimation()
        self.collectionView.reloadData()
    }
    
    private func configureSkeletonView(){
        self.collectionView.isSkeletonable = true
        self.collectionView.showGradientSkeleton(usingGradient: .init(baseColor: .clouds), transition: .crossDissolve(0.1))
        self.collectionView.startSkeletonAnimation()
    }
    
    private func setUpCollectionView(){
        collectionView.register(ImageCollectionView.self,
                                forCellWithReuseIdentifier: CollectionViewCell.ImageCollectionView.rawValue)
        collectionView.collectionViewLayout = self.compositionalLayout()
    }
    
    private func compositionalLayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout {(sectionIndex, env) in
            return CompositionalLayouts.characterGridLayout()
        }
        return layout
    }
    
}

extension CharactersByNameViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.marvelCharacters?.data.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.ImageCollectionView.rawValue, for: indexPath) as! ImageCollectionView
        cell.indexPath = indexPath
        cell.characters = self.viewModel.marvelCharacters?.data.results[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let count = self.viewModel.marvelCharacters?.data.results.count, indexPath.item == (count - 1){
            self.viewModel.offset += 1
            let param: [String: Any] = ["limit": self.viewModel.limit, "offset": self.viewModel.offset, "nameStartsWith": nameStartWith]
            self.getCharacters(param: param)
        }
    }
}

//MARK: - For Showing Skeleton Cells
extension CharactersByNameViewController: SkeletonCollectionViewDataSource{
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return CollectionViewCell.ImageCollectionView.rawValue
    }
    
}

//MARK: - Web Services
extension CharactersByNameViewController{
    
    
    private func getCharacters(param: [String: Any]){
        self.viewModel.characters(parameters: param) {[weak self] (success, message) in
            if success{
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            }else{
                if message == "Pagination Ended"{
                    //MARK: - Do Nothing
                }else{
                    DispatchQueue.main.async {
                        self?.showAutoToast(message: message)
                    }
                }
            }
        }
    }
    
}
