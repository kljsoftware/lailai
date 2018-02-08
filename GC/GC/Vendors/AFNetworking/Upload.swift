//
//  Upload.swift
//  GC
//
//  Created by hzg on 2018/2/8.
//  Copyright © 2018年 demo. All rights reserved.
//

class Upload {
    
    // 上传文件(仅支持图片)
    class func uploadFile(_ url: String, parameters: NSDictionary?, data: Data, success:@escaping ((_ dictionary:NSDictionary?) -> Void), failure: @escaping ((_ error:NSError) -> Void)) {
        
        // 上传请求
        var error:NSError?
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: url, parameters: parameters as? [String : AnyObject], constructingBodyWith: { (formData) in
            formData.appendPart(withFileData: data, name: "file", fileName: ".png", mimeType: "image/png")
        }, error: &error)
        Log.e("YJYAFNetworkingWrapper | error = \(String(describing: error?.description))")
        
        // 上传
        let manager = AFURLSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        let uploadTask = manager.uploadTask(withStreamedRequest: request as URLRequest, progress: { (progress) in
            Log.e("YJYAFNetworkingWrapper | uploadFileWithData progress = \(progress.fractionCompleted)")
        })  { (response, responseObject, error) in
            if error == nil {
                do {
                    let dic = try JSONSerialization.jsonObject(with: (responseObject as? Data)!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                    success(dic as? NSDictionary)
                } catch {
                    Log.e("YJYAFNetworkingWrapper | uploadFileWithData error")
                    success(nil)
                }
            } else {
                failure(error! as NSError)
            }
        }
        
        uploadTask.resume()
    }
}


