//
//  CommentViewController.swift
//  zzinmunication
//
//  Created by 홍경표 on 2022/09/11.
//

import UIKit

final class CommentViewController: UIViewController {

  private lazy var mainView = CommentView()

  override func loadView() {
    view = mainView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.topItem?.title = ""
    navigationController?.navigationBar.tintColor = UIColor(hexString: "#969696")
  }
}
