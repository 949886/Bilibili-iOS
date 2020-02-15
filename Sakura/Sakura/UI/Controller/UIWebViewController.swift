//
//  UIWebViewController.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation
import WebKit

@available(iOS 8.0, *)
open class UIWebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate {
    
    public typealias RedirectHandler = ((URL, [String : String]?) -> Void)
    
    public var webView: WKWebView!
    public var configuration: WKWebViewConfiguration = WKWebViewConfiguration()
    
    public var redirector = [String : RedirectHandler]()
    
    public var url: URL = URL(string: "about:blank")!
    
    //MARK: Initialization
    
    public init(url: String) {
        super.init(nibName: nil, bundle: nil)
        
        if let url = URL(string: url) {
            self.url = url
        }
       
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Override
    
    open override func loadView() {
        webView = WKWebView(frame: UIScreen.main.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view = webView
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteCookie()
        deleteCache()
        
        webView.load(URLRequest(url: url))
    }
    
    //MARK: Delegate
    
    /* WKNavigationDelegate */
    
    //Start loading.
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ///debugPrint("didStartProvisionalNavigation: \(webView.url)")
    }
    
    //Receive content.
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ///debugPrint("didCommit: \(webView.url)")
    }
    
    //Finish loading.
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ///debugPrint("didFinish: \(webView.url)")
    }
    
    //Loading failed.
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        ///debugPrint("didFailProvisionalNavigation: \(webView.url) Error:\(error)")
    }
    
    //Redirect received.
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        ///debugPrint("didReceiveServerRedirectForProvisionalNavigation: \(webView.url)")
        
        //Handle redirect with redirector.
        if  let url = webView.url,
            let components = URLComponents(string: url.absoluteString) {
            for (key, handler) in redirector {
                if url.absoluteString.hasPrefix(key) {
                    let parameters = components.queryItems?.reduce([String : String]()){
                        (result, element) -> [String : String] in
                        var result2 = result
                        result2[element.name] = element.value ?? ""
                        return result2
                    }
                    
                    handler(url, parameters)
                }
            }
        }
        
    }
    
    //Whether load before navigation.
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //1
        ///debugPrint("navigationAction: \(navigationAction.request.url) URL: \(webView.url) ")

        decisionHandler(.allow)
    }
    
    //Whether redirect after navigation.
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        ///debugPrint("navigationResponse: \(navigationResponse.response) URL: \(webView.url) ")
        decisionHandler(.allow)
    }
    
    /* WKUIDelegate */
    
    //When webview received javascript alert message.
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    /* WKScriptMessageHandler */
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
    //MARK: Methods
    
    open func deleteCookie() {
        let cookies = HTTPCookieStorage.shared.cookies
        for cookie in cookies! where cookies != nil  {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
    
    open func deleteCache() {
        URLCache.shared.removeAllCachedResponses()
    }
    
}
