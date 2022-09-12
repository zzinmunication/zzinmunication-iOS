//
//  TopicViewController.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

struct Topic: Hashable {
  let id: UUID = .init()
  let title: String
  let comments: [String]
}

final class TopicViewController: UIViewController {
  private let searchView: TopicSearchView = .init(frame: .zero)
  private let collectionView: TopicCollectionView = .init(frame: .zero)

  private lazy var dataSource = makeDataSource()

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

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLayout()
    setupUI()
    applySnapshot(animatingDifferences: false, topics: topics)
    searchView.textField.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let navigationBar = navigationController?.navigationBar
    navigationBar?.isHidden = false
    navigationBar?.barTintColor = .white
    navigationBar?.isTranslucent = true
    navigationBar?.setBackgroundImage(UIImage(), for: .default)
    navigationBar?.shadowImage = UIImage()
    navigationBar?.backgroundColor = .white
  }
}

extension TopicViewController: Presentable {

  func setupLayout() {
    [collectionView, searchView].forEach {
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

private extension TopicViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Topic>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Topic>

  enum Section: CaseIterable {
    case topic
  }

  func makeDataSource() -> DataSource {
    let dataSource = DataSource(
      collectionView: collectionView,
      cellProvider: { (collectionView, indexPath, topic) -> UICollectionViewCell? in
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TopicCell
        cell.configure(withViewModel: .init(title: topic.title))

        return cell
    })
    return dataSource
  }

  func applySnapshot(animatingDifferences: Bool = true, topics: [Topic]) {
    var snapshot = Snapshot()
    let sections = Section.allCases
    snapshot.appendSections(sections)
    sections.forEach { section in
      snapshot.appendItems(topics, toSection: section)
    }
    dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
  }
}

extension TopicViewController: UITextFieldDelegate {

  func textFieldDidChangeSelection(_ textField: UITextField) {
    guard let text = textField.text,
          !text.isEmpty else {
      applySnapshot(topics: topics)
      return
    }

    applySnapshot(topics: topics.filter { $0.title.contains(text) })
  }
}
