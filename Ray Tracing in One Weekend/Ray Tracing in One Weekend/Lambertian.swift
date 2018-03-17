//
//  Lambertian.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/17/18.
//

public class Lambertian: Material {
    let albedo: Vec3
    
    public init(albedo: Vec3) {
        self.albedo = albedo
    }
    
    public func scatter(rIn: Ray, rec: HitRecord, attenuation: inout Vec3, scattered: inout Ray) -> Bool {
        let target: Vec3 = rec.p + rec.normal + randomInUnitSphere()
        scattered = Ray(rec.p, target - rec.p)
        attenuation = albedo
        return true
    }
}
