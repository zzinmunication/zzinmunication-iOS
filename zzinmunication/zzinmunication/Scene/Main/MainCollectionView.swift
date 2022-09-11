//
//  MainCollectionView.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

final class MainCollectionView: UICollectionView {

  init(frame: CGRect) {
    super.init(
      frame: frame,
      collectionViewLayout: UICollectionViewCompositionalLayout(
        sectionProvider: Self.sectionProvider
      )
    )

    registerViews()
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  enum ElementKind {
    static let title = "title-element-kind"
  }
}

private extension MainCollectionView {

  func registerViews() {
    registerCell(ofType: AdvertisementCell.self)
    registerCell(ofType: MainTopicCell.self)
    registerCell(ofType: MainMoreCell.self)
    registerSupplementaryView(
      ofType: TitleSupplementaryView.self,
      ofKind: ElementKind.title
    )
  }

  func setupView() {
    backgroundColor = .systemBackground
    showsVerticalScrollIndicator = false

    layer.masksToBounds = false
  }
}

private extension MainCollectionView {

  static func sectionProvider(
    sectionIndex: Int,
    layoutEnvironment: NSCollectionLayoutEnvironment
  ) -> NSCollectionLayoutSection? {
    switch sectionIndex {
    case 0: return layoutSectionForAdvertisement()
    case 1: return layoutSectionForTopic()
    case 2: return layoutSectionForMore()
    default: return nil
    }
  }

  static func layoutSectionForAdvertisement() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(56)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0)
    section.boundarySupplementaryItems = [
      titleSupplementaryItem(heightDimension: .absolute(77))
    ]

    return section
  }

  static func layoutSectionForTopic() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(143/158/2)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 2)
    group.interItemSpacing = .fixed(13)

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0)
    section.interGroupSpacing = 14

    return section
  }

  static func layoutSectionForMore() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(65)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 21, leading: 0, bottom: 0, trailing: 0)

    return section
  }

  static func titleSupplementaryItem(
    heightDimension: NSCollectionLayoutDimension
  ) -> NSCollectionLayoutBoundarySupplementaryItem {
    let layoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: heightDimension
    )
    return NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: layoutSize,
      elementKind: ElementKind.title,
      alignment: .topLeading
    )
  }
}
