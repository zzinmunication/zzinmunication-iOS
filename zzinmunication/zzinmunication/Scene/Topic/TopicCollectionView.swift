//
//  TopicCollectionView.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/12.
//

import UIKit

final class TopicCollectionView: UICollectionView {

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
}

private extension TopicCollectionView {

  func registerViews() {
    registerCell(ofType: AdvertisementCell.self)
    registerCell(ofType: TopicCell.self)
  }

  func setupView() {
    backgroundColor = .systemBackground
    showsVerticalScrollIndicator = false

    layer.masksToBounds = false
  }
}

private extension TopicCollectionView {

  static func sectionProvider(
    sectionIndex: Int,
    layoutEnvironment: NSCollectionLayoutEnvironment
  ) -> NSCollectionLayoutSection? {
    return layoutSectionForAdvertisement()
  }

  static func layoutSectionForAdvertisement() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(65)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    section.interGroupSpacing = 21

    return section
  }
}
