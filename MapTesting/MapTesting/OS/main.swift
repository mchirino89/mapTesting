//
//  FakeDelegate.swift
//  MapTesting
//
//  Created by Mauricio Chirino on 01/11/20.
//

import UIKit

private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}

_ = UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    delegateClassName()
)
