//
//  HitableList.swift
//  Ray Tracing in One Weekend
//
//  Created by David Kopec on 3/17/18.
//  Copyright © 2018 David Kopec. All rights reserved.
//

public class HitableList: Hitable {
    public let list: [Hitable]
    public init(list: [Hitable]) {
        self.list = list
    }
    
    public func hit(r: Ray, tMin: Float, tMax: Float, rec: inout HitRecord) -> Bool {
        var tempRec: HitRecord = HitRecord(t: 0.0, p: Vec3(0, 0, 0), normal: Vec3(0, 0, 0)) // dummies because needs to be initialized
        var hitAnything: Bool = false
        var closestSoFar: Float = tMax
        for item in list {
            if item.hit(r: r, tMin: tMin, tMax: closestSoFar, rec: &tempRec) {
                hitAnything = true
                closestSoFar = tempRec.t
                rec = tempRec
            }
        }
        return hitAnything
    }
}
