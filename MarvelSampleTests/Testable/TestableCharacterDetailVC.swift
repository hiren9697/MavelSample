//
//  TestableCharacterDetailVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 05/09/24.
//

import UIKit
@testable import MarvelSample

/// Testable sub-class of CharacterDetailVC that loads dummy image instead of making api call to load image
class TestableCharacterDetailVC: CharacterDetailVC {
    override func loadImage() {
        imageView.image = UIImage(named: "dummy")
    }
}
