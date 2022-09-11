//
//  zzinmunicationTests.swift
//  zzinmunicationTests
//
//  Created by itzel.du on 2022/09/11.
//

import XCTest
@testable import zzinmunication

class zzinmunicationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
      let expect = expectation(description: "")
      let service = GetCommentServiceMock()
      Task {
        do {
          let comment = try await service.fetchRandomComment(forCategory: "변명이 필요할 때")
          print("@@", comment)
          XCTAssertEqual(comment, "잠시 화장실 좀 다녀올게요")
          expect.fulfill()
        } catch {
          XCTFail(error.localizedDescription)
        }
      }
      waitForExpectations(timeout: 5) { error in
        if let error = error {
          XCTFail("\(error.localizedDescription)")
        }
      }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
