//
//  Material.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/17/18.
//

public protocol Material {
    func scatter(rIn: Ray, rec: HitRecord, attenuation: inout Vec3, scattered: inout Ray) -> Bool
}
