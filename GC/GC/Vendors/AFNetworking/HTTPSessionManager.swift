//
//  HTTPSessionManager.swift
//  GC
//
//  Created by hzg on 2018/2/1.
//  Copyright © 2018年 demo. All rights reserved.
//

/// 枚举-请求方法
///
/// - GET: GET
/// - POST: POST
enum HTTPMethod {
    case GET
    case POST
}

/// 封装AFN网络请求工具
class HTTPSessionManager: AFHTTPSessionManager {

    /// 实例化对象
    static let shared: HTTPSessionManager = {
        let manager = HTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: ["text/html","application/json"]) as? Set<String>
        return manager
    }()
    
    /// 封装网络请求方法
    ///
    /// - Parameters:
    /// - Method: GET/POST, 默认是GET请求
    /// - URLString: 请求地址
    /// - parameters: 参数
    /// - completed: 结束回调
    func request(method:HTTPMethod = .GET, urlString: String, parameters: NSDictionary?, completed:@escaping ((_ json: AnyObject?, _ isSuccess: Bool)->())) {
        
        Log.e("urlString = \(urlString), parameters = \(String(describing: parameters))")
        
        /// 定义成功回调闭包
        let success = { (task: URLSessionDataTask,json: Any?)->() in
            completed(json as AnyObject?,true)
        }
        
        /// 定义失败回调闭包
        let failure = {(task: URLSessionDataTask?, error: Error)->() in
            completed(nil,false)
        }
        
        /// 通过请求方法,执行不同的请求
        // 如果是 GET 请求
        if method == .GET { // GET
            
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
            
        } else { // POST
            
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
