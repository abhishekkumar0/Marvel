//
//  CompositionalLayouts.swift
//  Marvel
//
//  Created by Abhishek on 12/10/23.
//

import UIKit
class CompositionalLayouts{
    
    class func characterGridLayout(header: NSCollectionLayoutBoundarySupplementaryItem? = nil) -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0/3.0),
                                                            heightDimension: .fractionalWidth(1.0/3.0)))
        item.contentInsets.trailing = 8
        item.contentInsets.bottom = 8
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .fractionalWidth(1.0/3)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 8
        if let header = header{
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
    
    class func comicsGridLayout(header: NSCollectionLayoutBoundarySupplementaryItem? = nil) -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25),
                                                            heightDimension: .fractionalWidth(0.4)))
        item.contentInsets.trailing = 8
        item.contentInsets.bottom = 8
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .fractionalWidth(0.4)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 8
        if let header = header{
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
    
    
    class func collectionViewHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .absolute(screenWidth),
                                                                      heightDimension: .estimated(100.0)),
                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .top)
    }
    
}
