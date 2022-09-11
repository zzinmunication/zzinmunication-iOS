//
//  CommentService.swift
//  zzinmunication
//
//  Created by 홍경표 on 2022/09/11.
//

import Foundation

protocol CommentServiceable {
  func fetchRandomComment(forCategory category: String) async throws -> String
}

struct CommentService: CommentServiceable {

  func fetchRandomComment(forCategory category: String) async throws -> String {
    return ""
  }

}
