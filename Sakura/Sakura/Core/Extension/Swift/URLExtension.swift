//
//  URLExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension URL
{
    public var queryParameters: [String:String] {
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
    
    public var queryItems: [URLQueryItem] {
        if let queryItems = components?.queryItems {
            return queryItems
        }
        return []
    }
    
    public var components: URLComponents? {
        return URLComponents(string: self.absoluteString)
    }
    
    /// Initialize from string, which allow percent encoding.
    init?(_ string: String) {
        if let percentEncoding = string.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            self.init(string: percentEncoding)
        }
        return nil
    }
}

extension URL
{
    public static func + (url: URL, newQueryItem: URLQueryItem) -> URL {
        return url + [newQueryItem]
    }
    
    /// Addition.
    public static func + (url: URL, newQueryItems: [URLQueryItem]) -> URL {
        if var components = url.components,
            let queryItems = components.queryItems {
            components.queryItems = queryItems + newQueryItems
            return components.url!
        }
        return url
    }
    
    public static func + (url: URL, queryParameters: [String:String]) -> URL {
        if var components = url.components,
            let queryItems = components.queryItems {
            components.queryItems = queryItems + queryParameters.map {
                URLQueryItem(name: $0, value: $1)
            }
            return components.url!
        }
        return url
    }
    
    public static func += (url: inout URL, newQueryItem: URLQueryItem) {
        url = url + newQueryItem
    }
    
    public static func += (url: inout URL, newQueryItems: [URLQueryItem]) {
        url = url + newQueryItems
    }
    
    public static func += (url: inout URL, queryParameters: [String:String]) {
        url = url + queryParameters
    }
    
}

