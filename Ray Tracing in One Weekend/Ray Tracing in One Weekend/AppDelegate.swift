//
//  AppDelegate.swift
//  Ray Tracing in One Weekend
//
//  Created by David Kopec on 3/16/18.
//  Copyright © 2018 David Kopec. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var widthField: NSTextField!
    @IBOutlet weak var heightField: NSTextField!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // this function based on https://stackoverflow.com/a/38596649/281461
    func imageFromPixels(width: Int, height: Int, pixels: [Pixel]) -> NSImage {
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo:CGBitmapInfo = CGBitmapInfo.byteOrder32Little
        let bitsPerComponent = 8 //number of bits in UInt8
        let bitsPerPixel = 4 * bitsPerComponent //ARGB uses 4 components
        let bytesPerRow = bitsPerPixel * width / 8 // bitsPerRow / 8 (in some cases, you need some paddings)
        let providerRef = CGDataProvider(
            data: NSData(bytes: pixels, length: height * bytesPerRow) //Do not put `&` as pixels is already an `UnsafePointer`
        )
        
        let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: bytesPerRow, //->not bits
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef!,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
        return NSImage(cgImage: cgim!, size: CGSize(width: width, height: height))
        
    }
    
    @IBAction func start(sender: AnyObject) {
        let width = widthField.integerValue
        let height = heightField.integerValue
        let pixels = rayTrace(width: width, height: height)
        let image = imageFromPixels(width: width, height: height, pixels: pixels)
        imageView.image = image
    }


}

