//
//  AdvertisementCell.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

final class AdvertisementCellViewModel: MainCellViewModelType {
  let title: String
  let cornerMask: CACornerMask

  init(title: String, cornerMask: CACornerMask = [.layerMinXMinYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]) {
    self.title = title
    self.cornerMask = cornerMask
  }
}

final class AdvertisementCell: UICollectionViewCell {
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

    layer.maskedCorners = []
  }
}

extension AdvertisementCell: Configuable {

  func configure(withViewModel viewModel: AdvertisementCellViewModel) {
    titleLabel.text = viewModel.title
    layer.maskedCorners = viewModel.cornerMask
  }
}

extension AdvertisementCell: Presentable {

  func setupLayout() {
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }

  func setupUI() {
    backgroundColor = UIColor(hexString: "#CFE1F8")
    titleLabel.font = .systemFont(ofSize: 22)
    titleLabel.textColor = UIColor(hexString: "#969696")
    layer.cornerRadius = 16
  }
}

private extension AdvertisementCell {

  func setupShadow() {
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 6 / 2
    layer.shadowColor = UIColor(hexString: "#000000", alpha: 0.16).cgColor
    layer.shadowOpacity = 0.5
    layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 3, width: layer.bounds.width, height: layer.bounds.height)).cgPath
  }
}
