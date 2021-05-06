//
//  ImageCache.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-05.
//

import Foundation

class ImageCache {

    private init() {}

    static let shared = NSCache<NSString, NSData>()
}
