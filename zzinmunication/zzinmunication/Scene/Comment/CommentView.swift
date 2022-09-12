//
//  CommentView.swift
//  zzinmunication
//
//  Created by 홍경표 on 2022/09/11.
//

import UIKit

struct CommentViewModel {
  let title: String
  let comments: [String]
}

final class CommentView: UIView {

  private let containerView: UIStackView = UIStackView()
  private var viewModel: CommentViewModel?

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .init(name: "NanumSquareL", size: 29)
    label.textColor = .init(hexString: "#5A5A5A")
    label.textAlignment = .center

    return label
  }()

  private let commentContainerView: UIStackView = {
    let stackView = UIStackView()
    stackView.backgroundColor = .init(hexString: "#FDFDFD")
    stackView.layer.cornerRadius = 16
    stackView.layer.shadowColor = UIColor(hexString: "#000000", alpha: 0.16).cgColor
    stackView.layer.shadowOffset = CGSize(width: 0, height: 3)
    stackView.layer.shadowOpacity = 0.5
    stackView.layer.shadowRadius = 3.0

    return stackView
  }()

  private let commentLabel: UILabel = {
    let label = UILabel()
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .init(hexString: "#5A5A5A")
    label.font = .init(name: "NanumSquareL", size: 54)

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
    label.textAlignment = .right
    label.textColor = .init(hexString: "#969696")
    label.font = .init(name: "NanumSquareL", size: 22)

    return label
  }()

  private let refreshButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
    button.tintColor = .init(hexString: "#5A5A5A")
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 22, bottom: 0, right: 0)
    button.addTarget(self, action: #selector(didTouchRefreshButton), for: .touchUpInside)

    return button
  }()

  private let tempBannerView: UIView = {
    let view = UIView()
    view.backgroundColor = .init(hexString: "#CFE1F8")
    view.layer.cornerRadius = 16
    view.layer.shadowColor = UIColor(hexString: "#000000", alpha: 0.16).cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 3)
    view.layer.shadowOpacity = 0.5
    view.layer.shadowRadius = 3.0

    let label: UILabel = .init()
    label.font = .init(name: "NanumSquareL", size: 22)
    label.textColor = .init(hexString: "#969696")
    label.text = "광고"

    view.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

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

extension CommentView: Presentable {
  func setupLayout() {
    containerView.axis = .vertical
    containerView.distribution = .fill
    containerView.alignment = .fill
    containerView.isLayoutMarginsRelativeArrangement = true
    containerView.directionalLayoutMargins = .init(top: 50, leading: 23, bottom: 20, trailing: 23)
    containerView.addArrangedSubview(titleLabel)
    containerView.setCustomSpacing(27, after: titleLabel)
    containerView.addArrangedSubview(commentContainerView)
    containerView.setCustomSpacing(58, after: commentContainerView)
    containerView.addArrangedSubview(tempBannerView)
    titleLabel.setContentHuggingPriority(.required, for: .vertical)
    tempBannerView.setContentHuggingPriority(.required, for: .vertical)
    commentContainerView.setContentHuggingPriority(.defaultLow, for: .vertical)

    commentContainerView.axis = .vertical
    commentContainerView.distribution = .fill
    commentContainerView.alignment = .fill
    commentContainerView.isLayoutMarginsRelativeArrangement = true
    commentContainerView.directionalLayoutMargins = .init(top: 0, leading: 12, bottom: 8, trailing: 12)
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
      refreshButton.heightAnchor.constraint(equalToConstant: 60),
      refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor),
      refreshContainerView.heightAnchor.constraint(equalTo: refreshButton.heightAnchor),
      tempBannerView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  func setupUI() {
    self.backgroundColor = .white
  }
}

extension CommentView: Configuable {

  func configure(withViewModel viewModel: CommentViewModel) {
    self.viewModel = viewModel

    titleLabel.text = viewModel.title
    commentLabel.text = viewModel.comments.randomElement()
  }
}

private extension CommentView {

  @objc
  func didTouchRefreshButton() {
    commentLabel.text = viewModel?.comments.randomElement()
  }
}

// MARK: Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CommentViewPreview: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewPreview { CommentView() }
    }
  }
}
#endif
