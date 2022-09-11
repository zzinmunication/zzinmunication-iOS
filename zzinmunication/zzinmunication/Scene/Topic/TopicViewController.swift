//
//  TopicViewController.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

struct Topic {
  let title: String
  let comments: [String]
}

struct Ad {
  let title: String
}

final class TopicViewController: UIViewController {
  private let searchView: TopicSearchView = .init(frame: .zero)
  private let collectionView: TopicCollectionView = .init(frame: .zero)

  private var topics: [Topic] = [
    .init(title: "심심할 때", comments: []),
    .init(title: "심심할 때", comments: []),
    .init(title: "심심할 때", comments: []),
    .init(title: "심심할 때", comments: []),
    .init(title: "심심할 때", comments: []),
    .init(title: "심심할 때", comments: []),
    .init(title: "심심할 때", comments: []),
    .init(title: "심심할 때", comments: [])
  ]
  private var ads: [Ad] = [.init(title: "광고"), .init(title: "광고")]

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = self
    setupLayout()
    setupUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.isHidden = false
  }
}

extension TopicViewController: Presentable {

  func setupLayout() {
    [searchView, collectionView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
      searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
      searchView.heightAnchor.constraint(equalToConstant: 38),

      collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 26),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23)
    ])
  }

  func setupUI() {
    view.backgroundColor = .white

    navigationItem.title = "찐들의 대화"
    navigationController?.navigationBar.topItem?.title = ""
    navigationController?.navigationBar.tintColor = UIColor(hexString: "#969696")
    navigationController?.navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor(hexString: "969696")
    ]
  }
}

extension TopicViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    topics.count + ads.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    if indexPath.row % 5 == 0 {
      let cell = collectionView.dequeueReusableCell(for: indexPath) as AdvertisementCell
      cell.configure(withViewModel: .init(title: ads[indexPath.row / 5].title))

      return cell
    }

    let cell = collectionView.dequeueReusableCell(for: indexPath) as TopicCell
    cell.configure(withViewModel: .init(title: topics[indexPath.row - (indexPath.row / 5) - 1].title))

    return cell
  }
}
