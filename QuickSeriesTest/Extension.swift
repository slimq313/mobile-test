//
//  File.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-13.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import Foundation

protocol Reusable: class {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
