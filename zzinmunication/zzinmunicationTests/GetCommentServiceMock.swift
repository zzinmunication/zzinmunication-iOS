//
//  GetCommentServiceMock.swift
//  zzinmunicationTests
//
//  Created by 홍경표 on 2022/09/11.
//

@testable import zzinmunication
import Foundation

struct GetCommentServiceMock: CommentServiceable {

  private struct Joke: Codable {
    let value: String
  }

  func fetchRandomComment(forCategory category: String) async throws -> String {
    try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
    let dummyTask = Task { () -> String in
      if category == "변명이 필요할 때" {
        return "잠시 화장실 좀 다녀올게요"
      } else {
        return "몰라요"
      }
    }
    return await dummyTask.value
  }

}
