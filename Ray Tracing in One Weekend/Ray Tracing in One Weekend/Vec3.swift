//
//  Vec3.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/16/18.
//

import simd

infix operator •: BitwiseShiftPrecedence
infix operator ×: BitwiseShiftPrecedence

public struct Vec3 {
    // MARK: model
    public var model: simd_float3
    
    // MARK: properties
    public var x: Float { get { return model.x } set { model.x = newValue } }
    public var y: Float { get { return model.y } set { model.y = newValue } }
    public var z: Float { get { return model.z } set { model.z = newValue } }
    public var r: Float { get { return model.x } set { model.x = newValue } }
    public var g: Float { get { return model.y } set { model.y = newValue } }
    public var b: Float { get { return model.z } set { model.z = newValue } }
    public var squaredLength: Float { return simd_length_squared(self.model) }
    public var length: Float { return simd_length(self.model) }
    public var unitVector: Vec3 { return self / length }
    
    static let Dummy: Vec3 = Vec3(0.0, 0.0, 0.0)
    
    // MARK: initialization
    public init(_ x: Float, _ y: Float, _ z: Float) {
        self.model = simd_float3(x: x, y: y, z: z)
    }
    
    public init(_ from: simd_float3) {
        self.model = from
    }

    // MARK: methods
    public mutating func makeUnitVector() {
        model *= (1.0 / length)
    }

    // MARK: custom operators
    // dot product
    public static func •(lhs: Vec3, rhs: Vec3) -> Float {
        return simd_dot(lhs.model, rhs.model)
    }
    
    public static func ×(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(simd_cross(lhs.model, rhs.model))
    }
    
    // MARK: operator overloads
    public static prefix func -(vec3: Vec3) -> Vec3 { return Vec3(-vec3.model) }
    
    public static func +(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(lhs.model + rhs.model)
    }
    
    public static func -(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(lhs.model - rhs.model)
    }
    
    public static func *(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(lhs.model * rhs.model)
    }
    
    public static func /(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(lhs.model / rhs.model)
    }
    
    public static func +(lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs)
    }
    
    public static func -(lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(lhs.x - rhs, lhs.y - rhs, lhs.z - rhs)
    }
    
    public static func *(lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(lhs.model * rhs)
    }
    
    public static func *(lhs: Float, rhs: Vec3) -> Vec3 {
        return Vec3(lhs * rhs.model)
    }
    
    public static func /(lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(lhs.model / rhs)
    }
    
    public static func +=(lhs: inout Vec3, rhs: Vec3) {
        lhs.model += rhs.model
    }
    
    public static func -=(lhs: inout Vec3, rhs: Vec3) {
        lhs.model -= rhs.model
    }
    
    public static func *=(lhs: inout Vec3, rhs: Vec3) {
        lhs.model *= rhs.model
    }
    
    public static func /=(lhs: inout Vec3, rhs: Vec3) {
        lhs.model /= rhs.model
    }
    
    public static func +=(lhs: inout Vec3, rhs: Float) {
        lhs.x += rhs; lhs.y += rhs; lhs.z += rhs;
    }
    
    public static func -=(lhs: inout Vec3, rhs: Float) {
        lhs.x -= rhs; lhs.y -= rhs; lhs.z -= rhs;
    }
    
    public static func *=(lhs: inout Vec3, rhs: Float) {
        lhs.model *= rhs
    }
    
    public static func /=(lhs: inout Vec3, rhs: Float) {
        lhs.model /= rhs
    }
    
    public subscript(index: Int) -> Float {
        return self.model[index]
    }
}
