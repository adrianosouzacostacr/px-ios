//
//  MercadoPagoService.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 5/2/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation

internal class MercadoPagoService: NSObject {

    let MP_DEFAULT_TIME_OUT = 15.0

    var baseURL: String!
    init (baseURL: String) {
        super.init()
        self.baseURL = baseURL
    }

    internal func request(uri: String, params: String?, body: Data?, method: HTTPMethod, headers: [String: String]? = nil, cache: Bool = true, success: @escaping (_ data: Data) -> Void,
                        failure: ((_ error: NSError) -> Void)?) {

        let url = baseURL + uri
        var requesturl = url

        if let params = params, !String.isNullOrEmpty(params), let escapedParams = params.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            requesturl += "?" + escapedParams
        }

        let Rurl = URL(string: requesturl)
        var request = URLRequest(url: Rurl!)
        request.httpMethod = HTTPMethod.post.rawValue
        //request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        MercadoPagoSDKV4.request(requesturl, method: method).responseData { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            debugPrint("All Response Info: \(response)")

            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                success(data)
            }
        }

//        let finalURL: NSURL = NSURL(string: requesturl)!
//        let request: NSMutableURLRequest
//        if cache {
//            request  = NSMutableURLRequest(url: finalURL as URL,
//                                           cachePolicy: .returnCacheDataElseLoad, timeoutInterval: MP_DEFAULT_TIME_OUT)
//        } else {
//            request = NSMutableURLRequest(url: finalURL as URL,
//                                          cachePolicy: .useProtocolCachePolicy, timeoutInterval: MP_DEFAULT_TIME_OUT)
//        }
//
//        #if DEBUG
//            print("\n--REQUEST_URL: \(finalURL)")
//        #endif
//
//        request.url = finalURL as URL
//        request.httpMethod = method
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        if let sdkVersion = PXServicesURLConfigs.PX_SDK_VERSION {
//            let value = "PX/iOS/" + sdkVersion
//            request.setValue(value, forHTTPHeaderField: "User-Agent")
//        }
//
//        if headers !=  nil && headers!.count > 0 {
//            for header in headers! {
//                request.setValue(header.value, forHTTPHeaderField: header.key)
//            }
//        }
//        if let body = body {
//            #if DEBUG
//                print("--REQUEST_BODY: \(body as! NSString)")
//            #endif
//            request.httpBody = body.data(using: String.Encoding.utf8)
//        }
//
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//
//        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: Error?) in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            if error == nil && data != nil {
//                do {
//                    #if DEBUG
//                        print("--REQUEST_RESPONSE: \(String(data: data!, encoding: String.Encoding.utf8) as! NSString)\n")
//                    #endif
//                    success(data!)
//                } catch {
//
//                    let e: NSError = NSError(domain: "com.mercadopago.sdk", code: NSURLErrorCannotDecodeContentData, userInfo: nil)
//                    failure?(e)
//                }
//            } else {
//                failure?(error! as NSError)
//            }
//        }
//    }
}
}
