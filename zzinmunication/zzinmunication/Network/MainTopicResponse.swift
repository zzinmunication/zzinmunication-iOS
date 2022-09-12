//
//  MainTopicResponse.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/12.
//

import Foundation

struct MainTopicResponse: Decodable {
  let title: String
  let comments: [String]
  let backgroundColor: String?
  let backgroundImage: String?
  let titleColor: String?
}
