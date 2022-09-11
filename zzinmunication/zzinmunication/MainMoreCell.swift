//
//  MainMoreCell.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

final class MainMoreCellViewModel: MainCellViewModelType {
  let title: String
  let iconImage: UIImage?

  init(title: String, iconImage: UIImage? = UIImage(systemName: "arrow.forward")) {
    self.title = title
    self.iconImage = iconImage
  }
}

final class MainMoreCell: UICollectionViewCell {
  private let titleLabel: UILabel = .init()
  private let iconImageView: UIImageView = .init()

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
    iconImageView.image = nil
  }
}

extension MainMoreCell: Configuable {

  func configure(withViewModel viewModel: MainMoreCellViewModel) {
    titleLabel.text = viewModel.title
    iconImageView.image = viewModel.iconImage
  }
}

extension MainMoreCell: Presentable {

  func setupLayout() {
    [titleLabel, iconImageView].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
      iconImageView.widthAnchor.constraint(equalToConstant: 30),

      titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23)
    ])
  }

  func setupUI() {
    backgroundColor = UIColor(hexString: "#FDFDFD")

    titleLabel.font = .systemFont(ofSize: 22)
    titleLabel.textColor = UIColor(hexString: "#969696")
    titleLabel.textAlignment = .right

    iconImageView.tintColor = UIColor(hexString: "#969696")

    layer.cornerRadius = 16
  }
}

private extension MainMoreCell {

  func setupShadow() {
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 6 / 2
    layer.shadowColor = UIColor(hexString: "#000000", alpha: 0.16).cgColor
    layer.shadowOpacity = 0.5
    layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 3, width: layer.bounds.width, height: layer.bounds.height)).cgPath
  }
}
