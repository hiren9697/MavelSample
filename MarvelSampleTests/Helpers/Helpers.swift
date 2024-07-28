//
//  Helpers.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit
import XCTest
@testable import MarvelSample

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

func triggerRefresh(_ refreshControl: UIRefreshControl) {
    refreshControl.sendActions(for: .valueChanged)
}

func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

func putInViewHeirarchy(_ vc: UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}

func loadJSON(fileName: String)-> Any? {
    guard let pathString = Bundle(for: MarvelSampleTests.self).path(forResource: fileName, ofType: "json") else {
        return nil
    }
    let url = URL(filePath: pathString)
    let data = try! Data(contentsOf: url)
    do {
        let anyObject = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
        return anyObject
    } catch {
        Log.error("Error in searlizing ComicsListEmpty JSON: \(error)")
        return nil
    }
}



