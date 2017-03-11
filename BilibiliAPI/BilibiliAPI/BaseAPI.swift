//
//  BaseAPI.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/3/10.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import Alamofire


public func test() {
    print("test")
    Alamofire.request("https://httpbin.org/get").responseJSON { response in
        print(response.request)  // original URL request
        print(response.response) // HTTP URL response
        print(response.data)     // server data
        print(response.result)   // result of response serialization
        
        if let JSON = response.result.value {
            print("JSON: \(JSON)")
        }
    }
}


open class BaseAPI
{
    public func test2()
    {
        print("test")
    }
}
