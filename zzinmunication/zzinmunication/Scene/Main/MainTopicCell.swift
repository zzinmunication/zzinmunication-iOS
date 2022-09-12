//
//  MainTopicCell.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

protocol Configuable {
  associatedtype ViewModelType

  func configure(withViewModel viewModel: ViewModelType)
}

protocol MainCellViewModelType { }

final class MainTopicCellViewModel: MainCellViewModelType {
  let backgroundImage: UIImage?
  let backgroundColor: UIColor
  let title: String
  let comments: [String]
  let titleColor: UIColor
  let cornerMask: CACornerMask

  init(
    backgroundImage: UIImage? = nil,
    backgroundColor: UIColor = UIColor(hexString: "#FDFDFD"),
    title: String,
    comments: [String] = [],
    titleColor: UIColor = UIColor(hexString: "#5A5A5A"),
    cornerMask: CACornerMask = []
  ) {
    self.backgroundImage = backgroundImage
    self.backgroundColor = backgroundColor
    self.title = title
    self.comments = comments
    self.titleColor = titleColor
    self.cornerMask = cornerMask
  }
}

final class MainTopicCell: UICollectionViewCell {
  private let backgroundImageView: UIImageView = .init()
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

    backgroundImageView.image = nil
    titleLabel.text = nil
    titleLabel.textColor = nil
  }
}

extension MainTopicCell: Configuable {

  func configure(withViewModel viewModel: MainTopicCellViewModel) {
    backgroundImageView.image = viewModel.backgroundImage
    backgroundColor = viewModel.backgroundColor
    titleLabel.text = viewModel.title
    titleLabel.textColor = viewModel.titleColor
    layer.maskedCorners = viewModel.cornerMask
  }
}

extension MainTopicCell: Presentable {

  func setupLayout() {
    [backgroundImageView, titleLabel].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 14),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ])
  }

  func setupUI() {
    titleLabel.font = .init(name: "NanumSquareB", size: 22)
    titleLabel.textAlignment = .right
    titleLabel.numberOfLines = 0

    layer.cornerRadius = 16
  }
}

private extension MainTopicCell {

  func setupShadow() {
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 6 / 2
    layer.shadowColor = UIColor(hexString: "#000000", alpha: 0.16).cgColor
    layer.shadowOpacity = 0.5
    layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
  }
}
