//
//  Camera.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/17/18.
//

import Foundation

public struct Camera {
    let lowerLeftCorner: Vec3
    let horizontal: Vec3
    let vertical: Vec3
    let origin: Vec3 // your eye
    
    init(lookFrom: Vec3, lookAt: Vec3, vup: Vec3, vfov: Float, aspect: Float) { // vfov is top to bottom in degrees
        let u: Vec3, v: Vec3, w: Vec3
        let theta: Float = vfov * Float.pi / 180
        let halfHeight = tan(theta / 2)
        let halfWidth = aspect * halfHeight
        origin = lookFrom
        w = (lookFrom - lookAt).unitVector
        u = (vup × w).unitVector
        v = w × u
        lowerLeftCorner = origin - halfWidth * u - halfHeight * v - w
        horizontal = 2 * halfWidth * u
        vertical = 2 * halfHeight * v
    }
    
    public func getRay(u: Float, v: Float) -> Ray {
        return Ray(origin, lowerLeftCorner + u * horizontal + v * vertical - origin)
    }
}
