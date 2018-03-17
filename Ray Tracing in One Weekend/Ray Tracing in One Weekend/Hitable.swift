//
//  Hitable.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/17/18.
//

public struct HitRecord {
    public var t: Float
    public var p: Vec3
    public var normal: Vec3
    public var mat: Material
    
    static let Dummy: HitRecord = HitRecord(t: 0.0, p: Vec3.Dummy, normal: Vec3.Dummy, mat: Metal(albedo: Vec3.Dummy, fuzz: 1.0))
}

public protocol Hitable {
    func hit(r: Ray, tMin: Float, tMax: Float, rec: inout HitRecord) -> Bool
}
