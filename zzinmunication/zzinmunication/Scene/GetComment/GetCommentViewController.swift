//
//  GetCommentViewController.swift
//  zzinmunication
//
//  Created by 홍경표 on 2022/09/11.
//

import UIKit

final class GetCommentViewController: UIViewController {

  private lazy var mainView = GetCommentView()

  override func loadView() {
    view = mainView
  }
  
}
