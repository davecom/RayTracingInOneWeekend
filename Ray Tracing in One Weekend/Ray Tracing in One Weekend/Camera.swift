//
//  Camera.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/17/18.
//

import Foundation

public struct Camera {
    let lowerLeftCorner: Vec3 = Vec3(-2.0, -1.0, -1.0)
    let horizontal: Vec3 = Vec3(4.0, 0.0, 0.0)
    let vertical: Vec3 = Vec3(0.0, 2.0, 0.0)
    let origin: Vec3 = Vec3(0.0, 0.0, 0.0) // your eye
    
    public func getRay(u: Float, v: Float) -> Ray {
        return Ray(origin, lowerLeftCorner + u * horizontal + v * vertical)
    }
}
