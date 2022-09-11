//
//  TopicCell.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/12.
//

import UIKit

final class TopicCellViewModel {
  let title: String

  init(title: String) {
    self.title = title
  }
}

final class TopicCell: UICollectionViewCell {
  private let titleLabel: UILabel = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
    setupUI()
    setupShadow()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    titleLabel.text = nil
  }
}

extension TopicCell: Presentable {

  func setupLayout() {
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }

  func setupUI() {
    backgroundColor = .init(hexString: "#FDFDFD")

    titleLabel.font = .init(name: "NanumSquareL", size: 22)
    titleLabel.textColor = .init(hexString: "#969696")

    layer.cornerRadius = 16
  }
}

extension TopicCell: Configuable {

  func configure(withViewModel viewModel: TopicCellViewModel) {
    titleLabel.text = viewModel.title
  }
}

private extension TopicCell {

  func setupShadow() {
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 6 / 2
    layer.shadowColor = UIColor(hexString: "#000000", alpha: 0.16).cgColor
    layer.shadowOpacity = 0.5
    layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
  }
}

