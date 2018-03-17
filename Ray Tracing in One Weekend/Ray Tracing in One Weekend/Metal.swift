//
//  Metal.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/17/18.
//

public class Metal: Material {
    let albedo: Vec3
    let fuzz: Float
    
    public init(albedo: Vec3, fuzz: Float) {
        self.albedo = albedo
        self.fuzz = fuzz < 1.0 ? fuzz : 1.0
    }
    
    func reflect(v: Vec3, n: Vec3) -> Vec3 {
        return v - 2 * v • n * n
    }
    
    public func scatter(rIn: Ray, rec: HitRecord, attenuation: inout Vec3, scattered: inout Ray) -> Bool {
        let reflected: Vec3 = reflect(v: rIn.direction.unitVector, n: rec.normal)
        scattered = Ray(rec.p, reflected + fuzz * randomInUnitSphere())
        attenuation = albedo
        return scattered.direction • rec.normal > 0
    }
}
