//
//  DataExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/19.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation
import zlib

//MARK: Data

extension Data
{

}

//MARK: Compression

extension Data
{
    
    func zip() -> Data?
    {
        return nil
    }
    
    func unzip() -> Data?
    {
        return nil
    }
    
    /// Gzip inflate.
    ///
    /// - Parameter level: Compresssion levels (1 - 9). Presets:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    /// - Returns: Inflated data.
    public func gzip(level: Int32 = Z_DEFAULT_COMPRESSION) -> Data?
    {
        if self.count == 0 { return Data() }
        
        var stream = z_stream()
        self.withUnsafeBytes { (bytes: UnsafePointer<Bytef>) in
            stream.next_in = UnsafeMutablePointer<Bytef>(mutating: bytes)
        }
        stream.avail_in = uint(self.count)
        
        if deflateInit2_(&stream, level, Z_DEFLATED, MAX_WBITS + 16, MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY, ZLIB_VERSION, Int32(MemoryLayout<z_stream>.size)) != Z_OK {
            return nil
        }
        
        var data = Data(capacity: 16384)
        while stream.avail_out == 0 {
            if Int(stream.total_out) >= data.count {
                data.count += 16384
            }
            data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<Bytef>) in
                stream.next_out = bytes.advanced(by: Int(stream.total_out))
            }
            stream.avail_out = uInt(data.count) - uInt(stream.total_out)
            deflate(&stream, Z_FINISH)
        }
        
        deflateEnd(&stream)
        data.count = Int(stream.total_out)
        
        return data
    }
    
    /// Gzip deflate.
    ///
    /// - Parameter level: Compresssion levels (1 - 9). Presets:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    /// - Returns: Deflated data.
    public func ungzip(level: Int32 = Z_DEFAULT_COMPRESSION) -> Data? {
        
        var stream = z_stream()
        self.withUnsafeBytes { (bytes: UnsafePointer<Bytef>) in
            stream.next_in = UnsafeMutablePointer<Bytef>(mutating: bytes)
        }
        stream.avail_in = uint(self.count)
        
        var status = inflateInit2_(&stream, MAX_WBITS + 32, ZLIB_VERSION, Int32(MemoryLayout<z_stream>.size))
        if status != Z_OK { return nil }
        
        var data = Data(capacity: self.count * 2)
        
        while status == Z_OK {
            if Int(stream.total_out) >= data.count {
                data.count += self.count / 2
            }
            data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<Bytef>) in
                stream.next_out = bytes + Int(stream.total_out)
            }
            stream.avail_out = uInt(data.count) - uInt(stream.total_out)
            status = inflate(&stream, Z_SYNC_FLUSH)
        }
        
        if inflateEnd(&stream) != Z_OK || status != Z_STREAM_END {
            return nil
        }
        
        data.count = Int(stream.total_out)
        return data
    }
    
}
