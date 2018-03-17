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
    let lensRadius: Float
    let u: Vec3, v: Vec3, w: Vec3
    
    func randomInUnitDisk() -> Vec3 {
        var p: Vec3
        repeat {
            p = 2.0 * Vec3(Float(drand48()), Float(drand48()), 0) - Vec3(1, 1, 0)
        } while (p • p) >= 1.0
        return p
    }
    
    init(lookFrom: Vec3, lookAt: Vec3, vup: Vec3, vfov: Float, aspect: Float, aperture: Float, focusDist: Float) { // vfov is top to bottom in degrees
        lensRadius = aperture / 2
        
        let theta: Float = vfov * Float.pi / 180
        let halfHeight = tan(theta / 2)
        let halfWidth = aspect * halfHeight
        origin = lookFrom
        w = (lookFrom - lookAt).unitVector
        u = (vup × w).unitVector
        v = w × u
        lowerLeftCorner = origin - halfWidth * focusDist * u - halfHeight * focusDist * v - focusDist * w
        horizontal = 2 * halfWidth * focusDist * u
        vertical = 2 * halfHeight * focusDist * v
    }
    
    public func getRay(s: Float, t: Float) -> Ray {
        let rd: Vec3 = lensRadius * randomInUnitDisk()
        let offset: Vec3 = u * rd.x + v * rd.y
        return Ray(origin + offset, lowerLeftCorner + s * horizontal + t * vertical - origin - offset)
    }
}
