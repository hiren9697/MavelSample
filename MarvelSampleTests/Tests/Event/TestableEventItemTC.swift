//
//  TestableEventItemTC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 25/08/24.
//

import UIKit
@testable import MarvelSample

class TestableEventItemTC: EventItemTC {
    
    override func loadImage(viewModel: EventItemVM) {
        iconImageView.image = UIImage(named: "dummy")
    }
}
