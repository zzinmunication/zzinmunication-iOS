//
//  TitleSupplementaryView.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

final class TitleSupplementaryView: UICollectionReusableView {

  private let titleLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  var title: String = "" {
    didSet {
      titleLabel.text = title
    }
  }
}

extension TitleSupplementaryView: Presentable {

  func setupLayout() {
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
    ])
  }

  func setupUI() {
    titleLabel.font = .systemFont(ofSize: 41)
    titleLabel.textColor = UIColor(hexString: "#969696")
  }
}
