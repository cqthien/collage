//  Project name: SimpleCollage
//  File name   : CollageDTO.swift
//
//  Author      : Thien Chu
//  Created date: 3/1/18
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2018 Home. All rights reserved.
//  --------------------------------------------------------------

import Foundation
import CoreGraphics
/// Optional

enum CollageType: String, Codable {
    case normal
    case heart
    case circle
    case custom
}

typealias Path = [String: [Cordinator]]

struct CollageDTO: Codable {

    // MARK: Class's properties
    let name: String
    // Store view key
    let views: [String]
    // Store constraints list
    let constraints: [String]

    var type: CollageType? = .normal
    
    var paths: Path?
    
    // MARK: Class's constructors
    init(name n: String, views v: [String], constraints c: [String], type t: CollageType? = .normal, paths p: Path? = nil) {
        name = n
        views = v
        constraints = c
        type = t
        paths = p
    }

    // MARK: Class's public methods
}

// For cordinator direction
enum Position: String, Codable {
    case anchor
    case top
    case left
    case bottom
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

public struct Cordinator: Codable {
    let x: CGFloat
    let y: CGFloat
    var position: Position?
    
    init(x: CGFloat, y: CGFloat, position: Position? = .anchor) {
        self.x = x
        self.y = y
        self.position = position
    }
}
