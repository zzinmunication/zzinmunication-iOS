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
  private var mainTopicviewModels: [MainTopicCellViewModel] = [] {
    didSet {
      collectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loadData()

    setupLayout()
    setupUI()

    collectionView.delegate = self
    collectionView.dataSource = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.isHidden = true
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

  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    if indexPath.section == 1 {
      let mainTopicViewModel = mainTopicviewModels[indexPath.row]
      let title = mainTopicViewModel.title.split(separator: "\n").reduce("") { $0 + $1 + " "}.trimmingCharacters(in: .whitespaces)
      let commentViewModel: CommentViewModel = .init(title: title, comments: mainTopicViewModel.comments)
      let viewController = CommentViewController(viewModel: commentViewModel)
      show(viewController, sender: self)
    }

    if indexPath.section == 2 {
      let viewController = TopicViewController()
      show(viewController, sender: self)
    }
  }
}

extension MainViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    3
  }
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    switch section {
    case 0: return 1
    case 1: return 6
    case 2: return 1
    default: return 0
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(for: indexPath) as AdvertisementCell
      let viewModel = advertisementCellViewModel(at: indexPath.row)
      cell.configure(withViewModel: viewModel)

      return cell

    case 1:
      let cell = collectionView.dequeueReusableCell(for: indexPath) as MainTopicCell
      if let viewModel = mainTopicCellViewModel(at: indexPath.row) {
        cell.configure(withViewModel: viewModel)
      }

      return cell

    case 2:
      let cell = collectionView.dequeueReusableCell(for: indexPath) as MainMoreCell
      let viewModel = MainMoreCellViewModel(title: "더 보러 가기")
      cell.configure(withViewModel: viewModel)

      return cell

    default:
      return UICollectionViewCell()
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    let headerView = collectionView.dequeueReusableSupplementaryView(
      ofKind: MainCollectionView.ElementKind.title,
      for: indexPath
    ) as TitleSupplementaryView

    headerView.title = "찐들의 대화"

    return headerView
  }
}

private extension MainViewController {

  func advertisementCellViewModel(at row: Int) -> AdvertisementCellViewModel {
    return .init(title: "광고", cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
  }

  func mainTopicCellViewModel(at row: Int) -> MainTopicCellViewModel? {
    if row < mainTopicviewModels.count {
      return mainTopicviewModels[row]
    }
    return nil
  }

  func loadData() {
    guard let url = URL(string: "https://zzinmunication.github.io/main-iOS.json")
    else { fatalError("Invalid URL") }

    let networkManager = NetworkManager()

    networkManager.request(fromURL: url) { [weak self] (result: Result<[MainTopicResponse], Error>) in
      switch result {
      case .success(let topics):
        self?.mainTopicviewModels = topics.enumerated().map { index, topic in
          switch index {
          case 0: return MainTopicCellViewModel(topic, cornerMask: [.layerMinXMinYCorner])
          case 1: return MainTopicCellViewModel(topic, cornerMask: [.layerMaxXMinYCorner])
          case 2: return MainTopicCellViewModel(topic)
          case 3: return MainTopicCellViewModel(topic)
          case 4: return MainTopicCellViewModel(topic, cornerMask: [.layerMinXMaxYCorner])
          default: return MainTopicCellViewModel(topic, cornerMask: [.layerMaxXMaxYCorner])
          }
        }
        debugPrint("We got a successful result with \(topics.count) topics.")
      case .failure(let error):
        debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
      }
    }
  }
}

private extension MainTopicCellViewModel {
  convenience init(_ response: MainTopicResponse, cornerMask: CACornerMask = []) {
    var backgroundImage: UIImage? = nil
    if let backgroundImageName = response.backgroundImage {
      backgroundImage = UIImage(named: backgroundImageName)
    }

    var backgroundColor: UIColor = .init(hexString: "#FDFDFD")
    if let backgroundColorHex = response.backgroundColor {
      backgroundColor = .init(hexString: backgroundColorHex)
    }

    var titleColor: UIColor = .init(hexString: "#5A5A5A")
    if let titleColorHex = response.titleColor {
      titleColor = .init(hexString: titleColorHex)
    }

    self.init(
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      title: response.title,
      comments: response.comments,
      titleColor: titleColor,
      cornerMask: cornerMask
    )
  }
}
