//
//  MainViewController.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

protocol Presentable {
  func setupLayout()
  func setupUI()
}

final class MainViewController: UIViewController {
  private let collectionView: MainCollectionView = .init(frame: .zero)

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLayout()
    setupUI()

    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

extension MainViewController: Presentable {

  func setupLayout() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23)
    ])
  }

  func setupUI() {
    view.backgroundColor = .white
  }
}

extension MainViewController: UICollectionViewDelegate {

}

extension MainViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    2
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0: return 1
    case 1: return 6
    default: return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(for: indexPath) as AdvertisementCell
      let viewModel = advertisementCellViewModel(at: indexPath.row)
      cell.configure(withViewModel: viewModel)

      return cell

    case 1:
      let cell = collectionView.dequeueReusableCell(for: indexPath) as MainTopicCell
      let viewModel = mainTopicCellViewModel(at: indexPath.row)
      cell.configure(withViewModel: viewModel)

      return cell

    default:
      return UICollectionViewCell()
    }
  }
}

private extension MainViewController {

  func advertisementCellViewModel(at row: Int) -> AdvertisementCellViewModel {
    return .init(title: "광고", cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
  }

  func mainTopicCellViewModel(at row: Int) -> MainTopicCellViewModel {
    let viewModel: MainTopicCellViewModel
    switch row {
    case 0:
      viewModel = .init(
        backgroundImage: UIImage(named: "main_cell_eat"),
        backgroundColor: UIColor(hexString: "#DB7669"),
        title: """
    밥
    먹을 때
""",
        titleColor: UIColor(hexString: "#EAEAEA"),
        cornerMask: [.layerMinXMinYCorner]
      )
    case 1:
      viewModel = .init(
        title: "심심할 때",
        cornerMask: [.layerMaxXMinYCorner]
      )
    case 2:
      viewModel = .init(
        title: "사과할 때",
        titleColor: UIColor(hexString: "#DB7669")
      )
    case 3:
      viewModel = .init(
        backgroundImage: UIImage(named: "main_cell_request"),
        backgroundColor: UIColor(hexString: "#FDEE9A"),
        title: """
        변명이
        필요할 때
        """
      )
    case 4:
      viewModel = .init(
        backgroundImage: UIImage(named: "main_cell_meeting"),
        backgroundColor: UIColor(hexString: "#A7DBC5"),
        title: """
소개팅
할 때
""",
        titleColor: UIColor(hexString: "#EAEAEA"),
        cornerMask: [.layerMinXMaxYCorner]
      )
    default:
      viewModel = .init(
        title: """
길거리에서
권유를
받았을 때
""",
        titleColor: UIColor(hexString: "#A7DBC5"),
        cornerMask: [.layerMaxXMaxYCorner]
      )
    }

    return viewModel
  }
}
