//
//  RayTrace.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/16/18.
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

func color(_ r: Ray, world: Hitable) -> Vec3 {
    var rec: HitRecord = HitRecord(t: 0.0, p: Vec3(0, 0, 0), normal: Vec3(0, 0, 0)) // dummies because needs to be initialized
    if world.hit(r: r, tMin: 0.0, tMax: Float.greatestFiniteMagnitude, rec: &rec)  {
        return 0.5 * Vec3(rec.normal.x + 1, rec.normal.y + 1, rec.normal.z + 1)
    }
    let unitDirection: Vec3 = r.direction.unitVector
    let t: Float = 0.5 * (unitDirection.y + 1.0)
    return (1.0 - t) * Vec3(1.0, 1.0, 1.0) + t * Vec3(0.5, 0.7, 1.0) // white to blue
}

func rayTrace(width: Int, height: Int) -> [Pixel] {
    var pixels: [Pixel] = [Pixel]()
    let lowerLeftCorner: Vec3 = Vec3(-2.0, -1.0, -1.0)
    let horizontal: Vec3 = Vec3(4.0, 0.0, 0.0)
    let vertical: Vec3 = Vec3(0.0, 2.0, 0.0)
    let origin: Vec3 = Vec3(0.0, 0.0, 0.0) // your eye
    let hitables: [Hitable] = [Sphere(center: Vec3(0, 0, -1), radius: 0.5), Sphere(center: Vec3(0, -100.5, -1), radius: 100)]
    let world = HitableList(list: hitables)
    for j in (0..<height).reversed() {
        for i in 0..<width {
            let u: Float = Float(i) / Float(width)
            let v: Float = Float(j) / Float(height)
            let r: Ray = Ray(origin, lowerLeftCorner + u * horizontal + v * vertical)
            
            let col: Vec3 = color(r, world: world)
            let ir: UInt8 = UInt8(255.99 * col.r)
            let ig: UInt8 = UInt8(255.99 * col.g)
            let ib: UInt8 = UInt8(255.99 * col.b)
            pixels.append(Pixel(r: ir, g: ig, b: ib))
        }
    }
    return pixels
}

