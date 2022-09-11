//
//  ListViewController.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

final class ListViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    setupLayout()
    setupUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.isHidden = false
  }
}

extension ListViewController: Presentable {

  func setupLayout() {

  }

  func setupUI() {
    navigationItem.title = "찐들의 대화"
    navigationController?.navigationBar.topItem?.title = ""
    navigationController?.navigationBar.tintColor = UIColor(hexString: "#969696")
    navigationController?.navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor(hexString: "969696")
    ]
  }
}
