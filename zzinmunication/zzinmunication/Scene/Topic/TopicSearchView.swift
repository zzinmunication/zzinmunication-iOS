//
//  TopicSearchView.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/12.
//

import UIKit

final class TopicSearchView: UIView {
  private let iconImageView: UIImageView = .init()
  let textField: UITextField = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
    setupUI()
    setupShadow()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TopicSearchView: Presentable {

  func setupLayout() {
    [iconImageView, textField].forEach {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),

      textField.centerYAnchor.constraint(equalTo: centerYAnchor),
      textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 2)
    ])
  }

  func setupUI() {
    backgroundColor = .init(hexString: "#FDFDFD")
    layer.cornerRadius = 16

    iconImageView.image = UIImage(systemName: "magnifyingglass")
    iconImageView.tintColor = UIColor(hexString: "#969696")

    textField.textColor = UIColor(hexString: "#5A5A5A")
    textField.placeholder = "Search"
    textField.font = .init(name: "NanumSquare", size: 17)
  }
}

private extension TopicSearchView {

  func setupShadow() {
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 6 / 2
    layer.shadowColor = UIColor(hexString: "#000000", alpha: 0.16).cgColor
    layer.shadowOpacity = 0.5
  }
}
