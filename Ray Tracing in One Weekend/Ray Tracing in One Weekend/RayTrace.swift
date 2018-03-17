//
//  RayTrace.swift
//  Ray Tracing in One Weekend
//
//  Created by David Kopec on 3/16/18.
//  Copyright © 2018 David Kopec. All rights reserved.
//

import Foundation

typealias Pixel = UInt32

extension Pixel {
    init(r: UInt8, g: UInt8, b: UInt8) {
        let r = UInt32(r)
        let g = UInt32(g)
        let b = UInt32(b)
        self = r << 24 | g << 16 | b << 8 | 0xFF
    }
}

func rayTrace(width: Int, height: Int) -> [Pixel] {
    var pixels: [Pixel] = [Pixel]()
    for j in (0..<height).reversed() {
        for i in 0..<width {
            let r: Float = Float(i) / Float(width)
            let g: Float = Float(j) / Float(height)
            let b: Float = 0.2
            let ir: UInt8 = UInt8(255.99 * r)
            let ig: UInt8 = UInt8(255.99 * g)
            let ib: UInt8 = UInt8(255.99 * b)
            pixels.append(Pixel(r: ir, g: ig, b: ib))
        }
    }
    return pixels
}

