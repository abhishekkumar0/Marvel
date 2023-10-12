//
//  FilterViewController.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import UIKit
import TagListView

class FilterViewController: UIViewController{
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped(sender: ))))
        return view
    }()
    
    private lazy var resetFilter: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = UIFont.fontWith(name: .Poppins, fontFace: .Regular, size: 15)
        button.setTitleColor(UIColor.colorFromHexString("504A4A"), for: .normal)
        button.addTarget(self, action: #selector(resetFilterButtonTapped(sender: )), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.fontWith(name: .Poppins, fontFace: .Black, size: 30)
        label.text = "Filter"
        return label
    }()

    private lazy var tagListView: TagListView = {
        let tagListView = TagListView()
        tagListView.translatesAutoresizingMaskIntoConstraints = false
        tagListView.tagBackgroundColor = .white
        tagListView.textFont = UIFont.fontWith(name: .Poppins, fontFace: .Regular, size: 15)
        tagListView.textColor = UIColor.colorFromHexString("313140")
        tagListView.paddingX = 12
        tagListView.paddingY = 12
        tagListView.marginX = 12
        tagListView.marginY = 12
        tagListView.delegate = self
        tagListView.tagSelectedBackgroundColor = UIColor.red
        return tagListView
    }()
    
    var delegate: SendData?
    internal let viewModel = FilterViewModel()
    private var tagListViewHeight: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.contentView.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
}

extension FilterViewController{
    
    private func configureView(){
        self.modifyLayouts()
        self.setUpConstraints()
        self.populatingTagListView()
    }
    
    private func modifyLayouts(){
        self.view.backgroundColor = .clear
        self.view.addSubviews([backgroundView, contentView])
        self.contentView.addSubviews([titleLabel, tagListView, resetFilter])
        backgroundView.frame = view.bounds
    }
    
    private func setUpConstraints(){
        tagListViewHeight = tagListView.heightAnchor.constraint(equalToConstant: 0)
        tagListViewHeight?.isActive = true
        
        NSLayoutConstraint.activate([
            
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor),
            
            tagListView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tagListView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            tagListView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            tagListView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -34),
            
            resetFilter.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            resetFilter.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
        ])
    }
    
    
    
    private func populatingTagListView(){
        let filters = [Filter(label: "Released this week", dateDescriptor: .thisWeek),
                       Filter(label: "Released last week", dateDescriptor: .lastWeek),
                       Filter(label: "Releasing next week", dateDescriptor: .nextWeek),
                       Filter(label: "Release this month", dateDescriptor: .thisMonth),]
        self.viewModel.filters = filters
        self.tagListView.setNeedsLayout()
        self.viewModel.filters.forEach({self.tagListView.addTag($0.label)})
        self.tagListView.tagViews.forEach({$0.setUpBorder(width: 1, color: .colorFromHexString("313140"), radius: $0.frame.height/2)})
        self.tagListView.layoutIfNeeded()
        self.tagListViewHeight?.constant = self.tagListView.intrinsicContentSize.height
        self.checkIfUserAlreadySelectedFilter()
    }
    
    private func checkIfUserAlreadySelectedFilter(){
        for (index,filter) in self.viewModel.filters.enumerated(){
            if filter.dateDescriptor.rawValue == self.viewModel.userSelectedFilter{
                self.tagListView.tagViews[index].isSelected = true
                break
            }
        }
    }
    
}

//MARK: - TagListViewMethods
extension FilterViewController: TagListViewDelegate{
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        for (i,j) in viewModel.filters.enumerated(){
            if title == j.label{
                self.delegate?.passData(dataPasser: self.viewModel.filters[i].dateDescriptor.rawValue, data: SENDDATA.FILTERSELECTED.rawValue)
                self.dismiss(animated: true)
                break
            }
        }
    }
}


//MARK: - UserInteraction
extension FilterViewController{
    
    @objc private func backgroundViewTapped(sender: UITapGestureRecognizer){
        self.delegate?.passData(dataPasser: true, data: SENDDATA.DISMISSVIEW.rawValue)
        self.dismiss(animated: true)
    }
    
    @objc private func resetFilterButtonTapped(sender: UITapGestureRecognizer){
        self.delegate?.passData(dataPasser: false, data: SENDDATA.FILTERSELECTED.rawValue)
        self.dismiss(animated: true)
    }
    
}
