//
//  TestableThumbnailTitleCC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 24/08/24.
//

import UIKit
@testable import MarvelSample

/// Subclass of ThumbnailTitleCC, should be used in tests to prevent actualu image fetch from web
/// Used in:
/// 1. TestableComicsVC
/// 2. TestableCharactersVC
/// 3. ThumbnailTitleCCTests
class TestableThumbnailTitleCC<ViewModel: ThumbnailTitleItemViewModel>: ThumbnailTitleCC<ViewModel> {
    
    override func loadImage() {
        imageView.image = UIImage(named: "dummy")
    }
}
