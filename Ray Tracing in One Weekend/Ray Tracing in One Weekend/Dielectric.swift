//
//  Dielectric.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/17/18.
//

import Foundation

public class Dielectric: Material {
    let refIdx: Float
    init(refIdx: Float) {
        self.refIdx = refIdx
    }
    
    public func scatter(rIn: Ray, rec: HitRecord, attenuation: inout Vec3, scattered: inout Ray) -> Bool {
        let outwardNormal: Vec3
        let reflected: Vec3 = reflect(v: rIn.direction, n: rec.normal)
        let niOverNt: Float
        attenuation = Vec3(1.0, 1.0, 1.0)
        var refracted: Vec3 = Vec3.Dummy
        let reflectProb: Float
        let cosine: Float
        if rIn.direction • rec.normal > 0 {
            outwardNormal = -rec.normal
            niOverNt = refIdx
            cosine = refIdx * (rIn.direction • rec.normal) / rIn.direction.length
        } else {
            outwardNormal = rec.normal
            niOverNt = 1.0 / refIdx
            cosine = -(rIn.direction • rec.normal) / rIn.direction.length
        }
        if refract(v: rIn.direction, n: outwardNormal, niOverNt: niOverNt, refracted: &refracted) {
            reflectProb = schlick(cosine: cosine, refIdx: refIdx)
        } else {
            reflectProb = 1.0
        }
        if Float(drand48()) < reflectProb {
            scattered = Ray(rec.p, reflected)
        } else {
            scattered = Ray(rec.p, refracted)
        }
        
        return true
        
    }
}
