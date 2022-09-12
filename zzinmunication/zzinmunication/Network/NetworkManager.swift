//
//  NetworkManager.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/12.
//

import Foundation

final class NetworkManager {

  enum ManagerErrors: Error {
    case invalidResponse
    case invalidStatusCode(Int)
  }

  enum HttpMethod: String {
    case get
    case post

    var method: String { rawValue.uppercased() }
  }

  func request<T: Decodable>(
    fromURL url: URL,
    httpMethod: HttpMethod = .get,
    completion: @escaping (Result<T, Error>
    ) -> Void) {
    let completionOnMain: (Result<T, Error>) -> Void = { result in
      DispatchQueue.main.async {
        completion(result)
      }
    }

    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.method

    let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completionOnMain(.failure(error))
        return
      }

      guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
      if !(200..<300).contains(urlResponse.statusCode) {
        return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
      }

      guard let data = data else { return }
      do {
        let users = try JSONDecoder().decode(T.self, from: data)
        completionOnMain(.success(users))
      } catch {
        debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
        completionOnMain(.failure(error))
      }
    }

    urlSession.resume()
  }
}
