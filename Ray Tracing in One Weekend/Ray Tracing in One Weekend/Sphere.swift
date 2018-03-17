//
//  Sphere.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/17/18.
//

import Foundation

struct Sphere: Hitable {
    let center: Vec3
    let radius: Float
    let material: Material
    
    func hit(r: Ray, tMin: Float, tMax: Float, rec: inout HitRecord) -> Bool {
        let oc: Vec3 = r.origin - center
        let a: Float = r.direction • r.direction
        let b: Float = oc • r.direction
        let c: Float = oc • oc - radius * radius
        let discriminant: Float = b * b - a * c
        if discriminant > 0 { // hit
            var temp: Float = (-b - discriminant.squareRoot()) / a // root 1
            if temp < tMax && temp > tMin {
                rec.t = temp
                rec.p = r.pointAt(temp)
                rec.normal = (rec.p - center) / radius
                rec.mat = material
                return true
            }
            temp = (-b + discriminant.squareRoot()) / a // root 2
            if temp < tMax && temp > tMin {
                rec.t = temp
                rec.p = r.pointAt(temp)
                rec.normal = (rec.p - center) / radius
                rec.mat = material
                return true
            }
            
        }
        return false // didn't hit
    }
}
