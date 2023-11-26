import Flutter
import UIKit
import XCTest

@testable import sign_in_with_apple_native

// This demonstrates a simple unit test of the Swift portion of this plugin's implementation.
//
// See https://developer.apple.com/documentation/xctest for more information about using XCTest.

class RunnerTests: XCTestCase {

  func testIsAvailable() {
    let plugin = SignInWithAppleNativePlugin()

    let call = FlutterMethodCall(methodName: "isAvailable", arguments: [])

    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      XCTAssertEqual(result as! Bool, true)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

}
