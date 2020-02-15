//
//  UIImageExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/13.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation
import CoreGraphics

//MARK: - Common

extension UIImage
{
    @objc public convenience init(color: UIColor) {
        self.init(color: color, size: CGSize(width: 1, height: 1))
    }
    
    @objc public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: size))
            if let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
                self.init(cgImage: image)
            } else { self.init() }
        } else { self.init() }
        UIGraphicsEndImageContext()
    }
    
    /// Get color at a pixel.
    /// - Note: Make sure if
    ///
    /// - Parameter point: Pixel coord.
    /// - Returns: Color in that pixel.
    @objc public func color(at point: CGPoint) -> UIColor? {
        guard let provider = cgImage?.dataProvider else{
            return nil
        }
        
        let data = provider.data
        let pointer: UnsafePointer<UInt8> = CFDataGetBytePtr(data)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4
        
        let r = CGFloat(pointer[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(pointer[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(pointer[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(pointer[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    /// Get average color of all pixel of image.
    @objc public func averageColor() -> UIColor? {
        return averageColor(in: CGRect(origin: .zero, size: self.size))
    }
    
    @objc public func averageColor(in rect: CGRect) -> UIColor? {
        return averageColor(in: rect, filter: nil)
    }
    
    @objc public func averageColor(withFilter filter: ((Double, Double, Double, Double)->Bool)?) -> UIColor? {
        return averageColor(in: CGRect(origin: .zero, size: self.size), filter: filter)
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - rect: <#rect description#>
    ///   - samplingRate: <#samplingRate description#>
    /// - Returns: <#return value description#>
    @objc public func averageColor(in rect: CGRect, filter: ((Double, Double, Double, Double)->Bool)?) -> UIColor? {
        if rect.width * rect.height > Int.max.f ||
           rect == .zero {
            return nil
        }
        
        var color: UIColor?
        
        if  let image = self.cropped(rect),
            let cgimage = image.cgImage {
            
            let width = Int(image.size.width)
            let height = Int(image.size.height)
            let pixelsCount = width * height
            
            if pixelsCount == 0 {
                return nil
            }
            
            if let provider = cgimage.dataProvider {
                let data = provider.data
                let pointer: UnsafePointer<UInt8> = CFDataGetBytePtr(data)
                
                var cumulativeRed = 0.0
                var cumulativeGreen = 0.0
                var cumulativeBlue = 0.0
                var cumulativeAlpha = 0.0
                
                var validPixelsCount = 0
                for i in 0..<pixelsCount {
                    let red   = Double(pointer[i * 4]) / 255.0;
                    let green = Double(pointer[i * 4 + 1]) / 255.0
                    let blue  = Double(pointer[i * 4 + 2]) / 255.0
                    let alpha = Double(pointer[i * 4 + 3]) / 255.0
                    
                    let retain = filter?(red, green, blue, alpha)
                    if retain ?? true {
                        validPixelsCount += 1
                        cumulativeRed += alpha == 0 ? 1.0 : red
                        cumulativeGreen += alpha == 0 ? 1.0 : green
                        cumulativeBlue += alpha == 0 ? 1.0 : blue
                        cumulativeAlpha += alpha
                    }
                }
                
                color = UIColor(red: cumulativeRed.f / validPixelsCount.f,
                                green: cumulativeGreen.f / validPixelsCount.f,
                                blue: cumulativeBlue.f / validPixelsCount.f,
                                alpha: cumulativeAlpha.f / validPixelsCount.f)
            }
        }
        return color
    }
}

//MARK: - Modify

extension UIImage
{
    
//    func modify(hue:Int, saturation: Int, brightness: Int) -> UIImage? {
//        return nil
//    }
    
    /// Get a resized image with a specific size.
    ///
    /// - Parameter size: New size.
    /// - Returns: Resized image.
    public func resized(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// Get a cropped image with a rect area.
    ///
    /// - Parameter rect: Crop rect.
    /// - Returns: Cropped image.
    public func cropped(_ rect: CGRect) -> UIImage? {
        if rect.contains(CGRect(origin: .zero, size: self.size)) {
            return self
        }
        if let image = self.cgImage?.cropping(to: rect) {
            return UIImage(cgImage: image)
        }
        return nil
    }
    
    /// Get a compressed image with a specific size.
    /// If original size of image is less than this size, image won't be compressed.
    ///
    /// - Parameter size: Compressed size (Unit: KB).
    /// - Returns: Compressed image.
    public func compressed(to size: CGFloat) -> UIImage? {
        if let byteCount = self.pngData()?.count {
            let originalSize = byteCount.f / 1024
            if size < originalSize {
                if let data = self.jpegData(compressionQuality: size / originalSize.f) {
                    return UIImage(data: data)
                }
                return nil
            }
        }
        return self
    }
    
    /// Get a compressed image with compression quality.
    ///
    /// - Parameter quality: Compression quality. Value range [0, 1].
    /// - Returns: Compressed image.
    public func compressed(quality: CGFloat) -> UIImage? {
        if let data = self.jpegData(compressionQuality: quality) {
            return UIImage(data: data)
        }
        return nil
    }
    
//    func flipped(_ type: FlipType) -> UIImage? {
//        return nil
//    }
//    
//    func rotated(angle: Double, closewise: Bool = true) -> UIImage? {
//        return nil
//    }
//    
//    func monochrome() -> UIImage? {
//        return nil
//    }
//    
//    enum FlipType {
//        case horizontal
//        case vertical
//    }
}

//MARK: - Gradient

//extension UIImage
//{
//    public enum GradientType
//    {
//        case linear(colors: [UIColor], loactions: [Float], startPoint: CGPoint, endPoint: CGPoint)
//        case bilinear(colors: [UIColor], colors2: [UIColor], loactions: [Float], loactions2: [Float], startPoint: CGPoint, endPoint: CGPoint, startPoint2: CGPoint, endPoint2: CGPoint)
//        case radial
//        case conical(colors: [UIColor], loactions: [Float], startAngle: Float, endAngle: Float)
//        case reflected
//        case diamond
//    }
//
//    public convenience init(gradientType: GradientType, size: CGSize) {
//        switch gradientType {
//        case .linear(let colors, let loactions, let startPoint, let endPoint):
//            break
//        default:
//            break
//        }
//
//        self.init()
//    }
//}

