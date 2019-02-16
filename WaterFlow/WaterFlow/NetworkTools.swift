
import AFNetworking

// 定义枚举类型
enum RequestType : String{
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
    static let shareInstance : NetworkTools = {
        let tool = NetworkTools()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        tool.responseSerializer.acceptableContentTypes?.insert("binary/octet-stream")
        return tool
    }()
}


extension NetworkTools{
    func request(methodType : RequestType, urlString: String, parameter : [String : AnyObject], finished : @escaping (_ result : AnyObject?, _ error : NSError?) -> ()){
        if methodType == .GET{
            get(urlString, parameters: parameter, success: { (task : URLSessionDataTask, result : Any?) in
                ZJPrint(message: result)
                finished(result as AnyObject?, nil)
            }, failure: { (task : URLSessionDataTask?, error : Error) in
                ZJPrint(message: error)
                finished(nil, error as NSError?)
            })
        }
        else{
            post(urlString, parameters: parameter, constructingBodyWith: nil
                , success: { (task :URLSessionDataTask, result : Any?) in
                    finished(result as AnyObject?, nil)
            }) { (task :URLSessionDataTask?, error : Error) in
                finished(nil, error as NSError?)
            }
        }
    }
}

