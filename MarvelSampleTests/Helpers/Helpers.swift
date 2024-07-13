//
//  Helpers.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit
import XCTest

func verifyMethodCalledOnce(methodName: String,
                            callCount: Int,
                            describedArguments: @autoclosure ()-> String,
                            file: StaticString,
                            line: UInt)-> Bool {
    if callCount == 0 {
        XCTFail("Wanted but not invoked: \(methodName)",
                file: file,
                line: line)
        return false
    } else if callCount > 1 {
        let message = """
                      Wanted 1 time but was called \(callCount) times,
                      method: \(methodName),
                      with: \(describedArguments())
                      """
        XCTFail(message, file: file, line: line)
        return false
    } else {
        return true
    }
}

func verifyMethodNeverCalled(methodName: String,
                             callCount: Int,
                             describedArguments: @autoclosure ()-> String,
                             file: StaticString,
                             line: UInt) {
    let times = callCount == 1 ? "time" : "times"
    if callCount > 0 {
        let message = """
                      Never wanted but was called: \(times),
                      method: \(methodName),
                      with: \(describedArguments())
                      """
        XCTFail(message,
                file: file,
                line: line)
    }
}

func systemItem(for barButtonItem: UIBarButtonItem)-> UIBarButtonItem.SystemItem {
    let systemItemNumber = barButtonItem.value(forKey: "systemItem") as! Int
    return UIBarButtonItem.SystemItem(rawValue: systemItemNumber)!
}

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

func tap(_ barButton: UIBarButtonItem) {
    _ = barButton.target?.perform(barButton.action, with: nil)
}

func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

func putInViewHeirarchy(_ vc: UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}
