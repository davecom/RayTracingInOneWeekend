//
//  Vec3.swift
//  Ray Tracing in One Weekend
//  Based on the Book by Peter Shirley
//  Released under the MIT License (see LICENSE)
//  Created by David Kopec on 3/16/18.
//

public struct Vec3 {
    // MARK: model
    public var x: Float
    public var y: Float
    public var z: Float
    
    // MARK: properties
    public var r: Float { get { return x } set { x = newValue } }
    public var g: Float { get { return y } set { y = newValue } }
    public var b: Float { get { return z } set { z = newValue } }
    public var squaredLength: Float { return x * x + y * y + z * z }
    public var length: Float { return squaredLength.squareRoot() }
    public var unitVector: Vec3 { return self / length }
    
    // MARK: initialization
    public init(_ x: Float, _ y: Float, _ z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    // MARK: methods
    public mutating func makeUnitVector() {
        let k: Float = 1.0 / length
        x *= k; y *= k; z *= k;
    }
    
    public func dot(_ other: Vec3) -> Float {
        return x * other.x + y * other.y + z * other.z
    }
    
    public func cross(_ other: Vec3) -> Vec3 {
        return Vec3(y * other.z - z * other.y, -(x * other.z - z * other.x), x * other.y - y * other.x)
    }
    
    // MARK: operator overloads
    public static prefix func -(vec3: Vec3) -> Vec3 { return Vec3(-vec3.x, -vec3.y, -vec3.z) }
    
    public static func +(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }
    
    public static func -(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
    }
    
    public static func *(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z)
    }
    
    public static func /(lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z)
    }
    
    public static func +(lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs)
    }
    
    public static func -(lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(lhs.x - rhs, lhs.y - rhs, lhs.z - rhs)
    }
    
    public static func *(lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs)
    }
    
    public static func *(lhs: Float, rhs: Vec3) -> Vec3 {
        return Vec3(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z)
    }
    
    public static func /(lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
    }
    
    public static func +=(lhs: inout Vec3, rhs: Vec3) {
        lhs.x += rhs.x; lhs.y += rhs.y; lhs.z += rhs.z;
    }
    
    public static func -=(lhs: inout Vec3, rhs: Vec3) {
        lhs.x -= rhs.x; lhs.y -= rhs.y; lhs.z -= rhs.z;
    }
    
    public static func *=(lhs: inout Vec3, rhs: Vec3) {
        lhs.x *= rhs.x; lhs.y *= rhs.y; lhs.z *= rhs.z;
    }
    
    public static func /=(lhs: inout Vec3, rhs: Vec3) {
        lhs.x /= rhs.x; lhs.y /= rhs.y; lhs.z /= rhs.z;
    }
    
    public static func +=(lhs: inout Vec3, rhs: Float) {
        lhs.x += rhs; lhs.y += rhs; lhs.z += rhs;
    }
    
    public static func -=(lhs: inout Vec3, rhs: Float) {
        lhs.x -= rhs; lhs.y -= rhs; lhs.z -= rhs;
    }
    
    public static func *=(lhs: inout Vec3, rhs: Float) {
        lhs.x *= rhs; lhs.y *= rhs; lhs.z *= rhs;
    }
    
    public static func /=(lhs: inout Vec3, rhs: Float) {
        lhs.x /= rhs; lhs.y /= rhs; lhs.z /= rhs;
    }
    
    
    public subscript(index: Int) -> Float {
        switch index {
        case 0:
            return x
        case 1:
            return y
        case 2:
            return z
        default:
            print("Invalid index!")
            if index < 0 { return self[3 - (abs(index) % 3)] } // wrap around
            return self[index % 3]
        }
    }
}
