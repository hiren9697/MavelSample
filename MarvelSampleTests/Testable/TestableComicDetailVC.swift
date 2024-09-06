//
//  TestableComicDetail.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 03/08/24.
//

import UIKit
@testable import MarvelSample

/// Testable sub-class of ComicDetailVC that loads dummy image instead of making api call to load image
class TestableComicDetailVC: ComicDetailVC {
    override func loadImage() {
        imageView.image = UIImage(named: "dummy")
    }
}
