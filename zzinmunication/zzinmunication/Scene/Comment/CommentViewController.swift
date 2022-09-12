//
//  CommentViewController.swift
//  zzinmunication
//
//  Created by 홍경표 on 2022/09/11.
//

import UIKit

final class CommentViewController: UIViewController {

  private lazy var mainView = CommentView()
  private let viewModel: CommentViewModel

  init(viewModel: CommentViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = mainView
    mainView.configure(withViewModel: viewModel)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.topItem?.title = ""
    navigationController?.navigationBar.tintColor = UIColor(hexString: "#969696")
  }
}
