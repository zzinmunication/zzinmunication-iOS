//
//  GetCommentService.swift
//  zzinmunication
//
//  Created by 홍경표 on 2022/09/11.
//

import Foundation

protocol GetCommentServiceable {
  func fetchRandomComment(forCategory category: String) async throws -> String
}

struct GetCommentService: GetCommentServiceable {

  func fetchRandomComment(forCategory category: String) async throws -> String {
    return ""
  }

}
