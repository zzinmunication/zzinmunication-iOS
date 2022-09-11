//
//  URLSession+dataFrom.swift
//  zzinmunication
//
//  Created by 홍경표 on 2022/09/11.
//

import Foundation

extension URLSession {
  @available(iOS, deprecated: 15.0, message: "Use `data(from:delegate:) async throws`, not this.")
  func dataFrom(url: URL, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
    return try await withCheckedThrowingContinuation { continuation in
      let task = self.dataTask(with: url) { data, response, error in
        guard let data = data, let response = response else {
          let error = error ?? URLError(.badServerResponse)
          return continuation.resume(throwing: error)
        }

        continuation.resume(returning: (data, response))
      }

      task.resume()
    }
  }
}
