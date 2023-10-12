//
//  HomeViewController.swift
//  Marvel
//
//  Created by Abhishek on 09/10/23.
//

import UIKit
import CryptoKit
import SkeletonView
import CoreData

class HomeViewController: UICollectionViewController{
    
    private lazy var searchController = UISearchController(searchResultsController: PreviousSearchesViewController())
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "App Bar Logo")
        return imageView
    }()
    
    private let viewModel = HomeViewModel()
    
    init() {
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

extension HomeViewController{
    
    private func configureView(){
        self.configureSkeletonView()
        self.setUpNavigationBar()
        self.setUpCollectionView()
        let param: [String: Any] = ["limit": self.viewModel.limit, "offset": self.viewModel.offset]
        self.getCharacters(param: param)
    }
    
    private func configureSkeletonView(){
        self.collectionView.isSkeletonable = true
        self.collectionView.showGradientSkeleton(usingGradient: .init(baseColor: .clouds), transition: .crossDissolve(0.1))
        self.collectionView.startSkeletonAnimation()
    }
    
    private func setUpNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.hidesBarsOnSwipe = true
        let logoView = UIBarButtonItem(customView: logoView())
        self.navigationItem.leftBarButtonItem = logoView
        self.searchController.showsSearchResultsController = true
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        
        navigationController?.navigationBar.largeContentImage = UIImage(named: "App Bar Logo")
    }
    
    private func setUpCollectionView(){
        collectionView.register(ImageCollectionView.self,
                                forCellWithReuseIdentifier: CollectionViewCell.ImageCollectionView.rawValue)
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CollectionViewCell.Header.rawValue)
        collectionView.collectionViewLayout = self.compositionalLayout()
    }
    
    private func compositionalLayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout {(sectionIndex, env) in
            return CompositionalLayouts.characterGridLayout(header: CompositionalLayouts.collectionViewHeader())
        }
        return layout
    }
    
}


extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        if let controller = searchController.searchResultsController as? PreviousSearchesViewController{
            controller.updateUserResults(text: searchController.searchBar.text ?? "")
            controller.userTappedOnSearchedResults = {[weak self] (search) in
                self?.openCharactersByNameViewController(nameStartingWith: search)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.saveSearchedDataToDB(text: text)
        self.openCharactersByNameViewController(nameStartingWith: text)
    }
    
    private func saveSearchedDataToDB(text: String){
        self.addDataSourceToSearchViewController(text: text)
    }
    
    private func addDataSourceToSearchViewController(text: String){
        guard let context = DatabaseOperations.shared.context else {return}
        let search = UserSearches(context: context)
        search.search = text
        if let controller = searchController.searchResultsController as? PreviousSearchesViewController{
            controller.updateData(userSearches: search)
            userTappedOnSearch?()
        }
    }
    
}

extension HomeViewController{
    
    private func logoView() -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logo)
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            logo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            logo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
        
        return view
    }
    
    private func getCharacters(param: [String: Any]){
        self.viewModel.characters(parameters: param) {[weak self] (success, message) in
            if success{
                DispatchQueue.main.async {
                    self?.updateUI()
                    
                }
            }else{
                DispatchQueue.main.async {
                    self?.showAutoToast(message: message)
                }
            }
        }
    }
    
    
    private func updateUI(){
        self.view.hideSkeleton()
        self.collectionView.stopSkeletonAnimation()
        self.collectionView.reloadData()
    }
    
    private func moveToCharacterDetail(id: Int){
        let vc = CharacterDetailsViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func headerTitle() -> NSMutableAttributedString{
        let str1 = Utilities.attributedText(text: "Marvel characters", font: UIFont.fontWith(name: .Poppins, fontFace: .ExtraBold, size: 14), color: .colorFromHexString("B7B7C8"))
        let str2 = Utilities.attributedText(text: "\nLearn about you Marvel Alliance.", font: UIFont.fontWith(name: .Poppins, fontFace: .Black, size: 30), color: .colorFromHexString("313140"))
        let combination = NSMutableAttributedString()
        combination.append(str1)
        combination.append(str2)
        return combination
    }
    
    private func saveDataToCoreData(){
        let context = appDelegate?.persistentContainer.viewContext
        do{
            try context?.save()
        }catch{
            self.showAutoToast(message: error.localizedDescription)
        }
    }
    
}

//MARK: - CollectionView Actions
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.marvelCharacters?.data.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.ImageCollectionView.rawValue, for: indexPath) as! ImageCollectionView
        cell.indexPath = indexPath
        cell.characters = self.viewModel.marvelCharacters?.data.results[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let count = self.viewModel.marvelCharacters?.data.results.count, indexPath.item == (count - 1){
            self.viewModel.offset += 1
            let param: [String: Any] = ["limit": self.viewModel.limit, "offset": self.viewModel.offset]
            print(param)
            self.getCharacters(param: param)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                   withReuseIdentifier: CollectionViewCell.Header.rawValue, for: indexPath) as! HeaderView
        cell.configureLabel(with: headerTitle())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.height, height: 200)
    }

}

//MARK: - For Showing Skeleton Cells
extension HomeViewController: SkeletonCollectionViewDataSource{
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return CollectionViewCell.ImageCollectionView.rawValue
    }
    
}
