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

func randomInUnitSphere() -> Vec3 {
    var p: Vec3
    repeat {
        p = 2.0 * Vec3(Float(drand48()), Float(drand48()), Float(drand48())) - Vec3(1, 1, 1)
    } while p.squaredLength >= 1.0
    return p
}

func color(_ r: Ray, world: Hitable, depth: Int) -> Vec3 {
    var rec: HitRecord = HitRecord.Dummy // dummies because needs to be initialized
    if world.hit(r: r, tMin: 0.001, tMax: Float.greatestFiniteMagnitude, rec: &rec)  {
        var scattered: Ray = Ray.Dummy
        var attenuation: Vec3 = Vec3.Dummy
        if depth >= 0 && rec.mat.scatter(rIn: r, rec: rec, attenuation: &attenuation, scattered: &scattered) {
            return attenuation * color(scattered, world: world, depth: depth - 1)
        } else {
            return Vec3.Dummy
        }
    }
    let unitDirection: Vec3 = r.direction.unitVector
    let t: Float = 0.5 * (unitDirection.y + 1.0)
    return (1.0 - t) * Vec3(1.0, 1.0, 1.0) + t * Vec3(0.5, 0.7, 1.0) // white to blue
}

func rayTrace(width: Int, height: Int) -> [Pixel] {
    var pixels: [Pixel] = [Pixel]()
    let numSamples: Int = 100
    let hitables: [Hitable] = [Sphere(center: Vec3(0, 0, -1), radius: 0.5, material: Lambertian(albedo: Vec3(0.8, 0.3, 0.3))),
                               Sphere(center: Vec3(0, -100.5, -1), radius: 100, material: Lambertian(albedo: Vec3(0.8, 0.8, 0.0))),
                               Sphere(center: Vec3(1, 0, -1), radius: 0.5, material: Metal(albedo: Vec3(0.8, 0.6, 0.2), fuzz: 0.3)),
                               Sphere(center: Vec3(-1, 0, -1), radius: 0.5, material: Metal(albedo: Vec3(0.8, 0.8, 0.8), fuzz: 1.0))]
    let world = HitableList(list: hitables)
    let camera: Camera = Camera()
    let fw: Float = Float(width)
    let fh: Float = Float(height)
    for j in (0..<height).reversed() {
        for i in 0..<width {
            var col: Vec3 = Vec3.Dummy
            let fi: Float = Float(i)
            let fj: Float = Float(j)
            for _ in 0..<numSamples {
                let u: Float = (fi + Float(drand48())) / fw
                let v: Float = (fj + Float(drand48())) / fh
                let r: Ray = camera.getRay(u: u, v: v)
                col += color(r, world: world, depth: 50)
            }
            col /= Float(numSamples)
            col = Vec3(col.x.squareRoot(), col.y.squareRoot(), col.z.squareRoot()) // raise to gamma 1/2
            let ir: UInt8 = UInt8(255.99 * col.r)
            let ig: UInt8 = UInt8(255.99 * col.g)
            let ib: UInt8 = UInt8(255.99 * col.b)
            pixels.append(Pixel(r: ir, g: ig, b: ib))
        }
    }
    return pixels
}

