//
//  GetCommentView.swift
//  zzinmunication
//
//  Created by 홍경표 on 2022/09/11.
//

import UIKit

final class GetCommentView: UIView {

  private let containerView: UIStackView = UIStackView()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "변명이 필요할 때" // TODO: DI or binding
    // TODO: 폰트 수정, numberOfLines = ?
    label.textAlignment = .center
    return label
  }()

  private let commentContainerView: UIStackView = {
    let stackView = UIStackView()
    stackView.backgroundColor = .systemBackground
    // TODO: 그림자 디테일 수정
    stackView.layer.cornerRadius = 10
    stackView.layer.shadowColor = UIColor.black.cgColor
    stackView.layer.shadowOffset = CGSize(width: 0, height: 3)
    stackView.layer.shadowOpacity = 0.5
    stackView.layer.shadowRadius = 3.0
    return stackView
  }()

  private let commentLabel: UILabel = {
    let label = UILabel()
    label.text = "잠시 화장실 좀 다녀올게요"
    // TODO: 폰트 수정
    label.textAlignment = .center
    return label
  }()

  private let refreshContainerView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .bottom
    return stackView
  }()

  private let refreshLabel: UILabel = {
    let label = UILabel()
    label.text = "다른 멘트 주세요"
    // TODO: 폰트 수정
    label.textAlignment = .right
    return label
  }()

  private let refreshButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(systemName: "arrow.clockwise.circle.fill"), for: .normal) // TODO: 이미지 변경
    return button
  }()

  private let tempBannerView: UIView = {
    // TODO: 광고 넣으면 수정
    let view = UIView()
    view.backgroundColor = .systemTeal
    // TODO: 그림자 디테일 수정
    view.layer.cornerRadius = 10
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 3)
    view.layer.shadowOpacity = 0.5
    view.layer.shadowRadius = 3.0
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupLayout()
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupLayout()
    setupUI()
  }

}

extension GetCommentView: Presentable {
  func setupLayout() {
    containerView.axis = .vertical
    containerView.distribution = .fill
    containerView.alignment = .fill
    containerView.isLayoutMarginsRelativeArrangement = true
    // TODO: 디테일 수정
    containerView.directionalLayoutMargins = .init(top: 50, leading: 23, bottom: 20, trailing: 23)
    containerView.addArrangedSubview(titleLabel)
    containerView.setCustomSpacing(30, after: titleLabel)
    containerView.addArrangedSubview(commentContainerView)
    containerView.setCustomSpacing(50, after: commentContainerView)
    containerView.addArrangedSubview(tempBannerView)
    titleLabel.setContentHuggingPriority(.required, for: .vertical)
    tempBannerView.setContentHuggingPriority(.required, for: .vertical)
    commentContainerView.setContentHuggingPriority(.defaultLow, for: .vertical)

    commentContainerView.axis = .vertical
    commentContainerView.distribution = .fill
    commentContainerView.alignment = .fill
    commentContainerView.addArrangedSubview(commentLabel)
    commentContainerView.addArrangedSubview(refreshContainerView)
    commentLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    commentLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    refreshContainerView.setContentHuggingPriority(.required, for: .vertical)

    refreshContainerView.axis = .horizontal
    refreshContainerView.distribution = .fill
    refreshContainerView.addArrangedSubview(refreshLabel)
    refreshContainerView.addArrangedSubview(refreshButton)
    refreshButton.setContentHuggingPriority(.required, for: .horizontal)

    addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      refreshButton.heightAnchor.constraint(equalToConstant: 30),
      refreshButton.widthAnchor.constraint(equalToConstant: 30),
      refreshContainerView.heightAnchor.constraint(equalTo: refreshButton.heightAnchor),
      tempBannerView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  func setupUI() {
    self.backgroundColor = .systemBackground
  }
}

// MARK: Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct GetCommentViewPreview: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewPreview { GetCommentView() }
    }
  }
}
#endif
