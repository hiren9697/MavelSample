//
//  TestableEventDetailVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 07/09/24.
//

import UIKit
@testable import MarvelSample

/// Testable sub-class of EventDetailVC that loads dummy image instead of making api call to load image
class TestableEventDetailVC: EventDetailVC {
    override func loadImage() {
        imageView.image = UIImage(named: "dummy")
    }
}
