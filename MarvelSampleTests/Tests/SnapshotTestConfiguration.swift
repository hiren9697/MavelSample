//
//  SnapshotTestConfiguration.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 28/09/24.
//

import Foundation
import SnapshotTesting

struct SnapshotTestConfiguration {
    static let isRecordingEnabled: Bool = false
    static let snapshottingForViewController: Snapshotting = .image(on: .iPhone8(.portrait))
    static func snapshottingForView(size: CGSize)-> Snapshotting<UIView, UIImage> { .image(size: size) }
}
