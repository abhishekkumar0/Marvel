//
//  ComicNavigationController.swift
//  Marvel
//
//  Created by Abhishek on 09/10/23.
//

import UIKit
import SkeletonView

class ComicsViewController: UICollectionViewController{
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "App Bar Logo")
        return imageView
    }()
    
    private lazy var filter: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon-filter"), for: .normal)
        button.tintColor = UIColor.colorFromHexString("504A4A")
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.addTarget(self, action: #selector(filterButtonTapped(sender: )), for: .touchUpInside)
        return button
    }()
    
    private let alphaView = AlphaView()
    
    private let viewModel = ComicsViewModel()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder is not initialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
}

extension ComicsViewController{
    
    private func configureView(){
        self.view.addSubview(alphaView)
        self.alphaView.frame = self.view.frame
        self.configureSkeletonView()
        self.setUpNavigationBar()
        self.setUpCollectionView()
        let param: [String: Any] = ["limit": self.viewModel.limit, "offset": self.viewModel.offset]
        self.getComics(param: param)
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
        
        let filterButton = UIBarButtonItem(customView: filter)
        self.navigationItem.rightBarButtonItem = filterButton
        
        navigationController?.navigationBar.largeContentImage = UIImage(named: "App Bar Logo")
    }
    
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
    
    private func updateUI(){
        self.collectionView.stopSkeletonAnimation()
        self.view.hideSkeleton()
        self.collectionView.reloadData()
    }
    
    private func headerTitle() -> NSMutableAttributedString{
        
        let str1 = Utilities.attributedText(text: "Marvel Comics", font: UIFont.fontWith(name: .Poppins, fontFace: .ExtraBold, size: 14), color: .colorFromHexString("B7B7C8"))
        let str2 = Utilities.attributedText(text: "\nGet Your Favourite Marvel Comics.", font: UIFont.fontWith(name: .Poppins, fontFace: .Black, size: 30), color: .colorFromHexString("313140"))
        let combination = NSMutableAttributedString()
        combination.append(str1)
        combination.append(str2)
        return combination
    }
    
    private func setUpCollectionView(){
        self.collectionView.collectionViewLayout = self.collectionViewLayout()
        collectionView.register(ImageCollectionView.self, 
                                forCellWithReuseIdentifier: CollectionViewCell.ImageCollectionView.rawValue)
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CollectionViewCell.Header.rawValue)
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout {(section, env) in
            return CompositionalLayouts.comicsGridLayout(header: CompositionalLayouts.collectionViewHeader())
        }
        return layout
    }
    
}

//MARK: - User Interaction
extension ComicsViewController{
    @objc private func filterButtonTapped(sender: UIButton){
        self.openFilter()
    }
    
    private func openFilter(){
        self.alphaView.showView()
        let vc = FilterViewController()
        vc.delegate = self
        vc.viewModel.userSelectedFilter = self.viewModel.dateDescriptor
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

//MARK: - CollectionView Delegate and DataSource
extension ComicsViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.comic?.data?.results?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.ImageCollectionView.rawValue, for: indexPath) as! ImageCollectionView
        cell.indexPath = indexPath
        cell.comics = self.viewModel.comic?.data?.results?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let count = self.viewModel.comic?.data?.results?.count, indexPath.item == (count - 1) , let data = self.viewModel.comic?.data?.total, data > count{
            self.viewModel.offset += 1
            var param: [String: Any] = ["limit": self.viewModel.limit, "offset": self.viewModel.offset]
            if let dateDescription = self.viewModel.dateDescriptor{
                param["dateDescriptor"] = dateDescription
            }
            self.getComics(param: param)
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
extension ComicsViewController: SkeletonCollectionViewDataSource{
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return CollectionViewCell.ImageCollectionView.rawValue
    }
}

extension ComicsViewController: SendData{
    func passData(dataPasser: Any, data: Any) {
        guard let data = data as? String else { return }
        switch data{
        case SENDDATA.DISMISSVIEW.rawValue:
            self.alphaView.hideView()
        case SENDDATA.FILTERSELECTED.rawValue:
            self.alphaView.hideView()
            guard let dataPasser = dataPasser as? String else {
                self.filterComics(dateDescriptor: nil)
                return
            }
            self.filterComics(dateDescriptor: dataPasser)
        default:
            break
        }
    }
}


//MARK: - Web Services
extension ComicsViewController{
    
    private func getComics(param: [String: Any]){
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
    
    private func filterComics(dateDescriptor: String?){
        self.viewModel.comic?.data?.results = []
        self.collectionView.reloadData()
        self.configureSkeletonView()
        self.viewModel.offset = 0
        self.viewModel.dateDescriptor = dateDescriptor != nil ? dateDescriptor : nil
        var param: [String: Any] = ["limit": self.viewModel.limit, "offset": self.viewModel.offset]
        if let dateDescriptor = self.viewModel.dateDescriptor{
            param["dateDescriptor"] = dateDescriptor
        }
        self.getComics(param: param)
    }
    
}
