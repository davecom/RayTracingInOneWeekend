//
//  RayTrace.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/16/18.
//

import Foundation

func color(_ r: Ray, world: Hitable, depth: Int) -> Vec3 {
    var rec: HitRecord = HitRecord.Dummy // dummy because needs to be initialized
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

func randomScene() -> Hitable {
    var list: [Hitable] = [Hitable]()
    list.append(Sphere(center: Vec3(0,-1000,0), radius: 1000, material: Lambertian(albedo: Vec3(0.5, 0.5, 0.5))))
    for a: Int in -11..<11 {
        for b: Int in -11..<11 {
            let chooseMat = Float(drand48())
            let center: Vec3 = Vec3(Float(a) + 0.9 * Float(drand48()), 0.2, Float(b) + 0.9 * Float(drand48()))
            if (center - Vec3(4, 0.2, 0)).length > 0.9 {
                if chooseMat < 0.8 { // diffuse
                    list.append(Sphere(center: center, radius: 0.2, material: Lambertian(albedo: Vec3(Float(drand48() * drand48()), Float(drand48() * drand48()), Float(drand48() * drand48())))))
                } else if chooseMat < 0.95 { // metal
                    list.append(Sphere(center: center, radius: 0.2, material: Metal(albedo: Vec3(0.5*(1 + Float(drand48())), 0.5*(1 + Float(drand48())), 0.5*(1 + Float(drand48()))), fuzz: 0.5 * Float(drand48()))))
                } else { // glass
                    list.append(Sphere(center: center, radius: 0.2, material: Dielectric(refIdx: 1.5)))
                }
            }
        }
    }
    list.append(Sphere(center: Vec3(0, 1, 0), radius: 1.0, material: Dielectric(refIdx: 1.5)))
    list.append(Sphere(center: Vec3(-4, 1, 0), radius: 1.0, material: Lambertian(albedo: Vec3(0.4, 0.2, 0.1))))
    list.append(Sphere(center: Vec3(4, 1, 0), radius: 1.0, material: Metal(albedo: Vec3(0.7, 0.6, 0.5), fuzz: 0.0)))
    return HitableList(list: list)
}

func rayTrace(width: Int, height: Int) -> [Pixel] {
    var pixels: [Pixel] = [Pixel]()
    let numSamples: Int = 10
//    let hitables: [Hitable] = [Sphere(center: Vec3(0, 0, -1), radius: 0.5, material: Lambertian(albedo: Vec3(0.1, 0.2, 0.5))),
//                               Sphere(center: Vec3(0, -100.5, -1), radius: 100, material: Lambertian(albedo: Vec3(0.8, 0.8, 0.0))),
//                               Sphere(center: Vec3(1, 0, -1), radius: 0.5, material: Metal(albedo: Vec3(0.8, 0.6, 0.2), fuzz: 0.3)),
//                               Sphere(center: Vec3(-1, 0, -1), radius: 0.5, material: Dielectric(refIdx: 1.5)),
//                               Sphere(center: Vec3(-1, 0, -1), radius: -0.45, material: Dielectric(refIdx: 1.5))]
//    let world = HitableList(list: hitables)
    let world = randomScene()
    let lookFrom: Vec3 = Vec3(13, 2, 3)
    let lookAt: Vec3 = Vec3(0, 0, 0)
    let distToFocus: Float = 10.0
    let aperture: Float = 0.1
    let camera: Camera = Camera(lookFrom: lookFrom, lookAt: lookAt, vup: Vec3(0, 1, 0), vfov: 20, aspect: Float(width)/Float(height), aperture: aperture, focusDist: distToFocus)
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
                let r: Ray = camera.getRay(s: u, t: v)
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

