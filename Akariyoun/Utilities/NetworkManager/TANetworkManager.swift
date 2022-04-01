//
//  TANetworkManager.swift
//  TANetworkingSwift

//

import UIKit
import Alamofire
import SVProgressHUD

let AlmofireApiInstanse = TANetworkManager.sharedInstance
let iimageCache = NSCache<NSString, AnyObject>()


extension UIImageView {
    
    //MARK:- Func for downlode image
    func downlodeImage(serviceurl:String , placeHolder: UIImage?) {
        
        self.image = placeHolder
        let urlString = serviceurl
        guard let url = URL(string: urlString.replacingOccurrences(of:  " ", with: "%20")) else { return }
        
        //MARK:- Check image Store in Cache or not
        if let cachedImage = iimageCache.object(forKey: urlString.replacingOccurrences(of: " ", with: "%20") as NSString) {
            if  let image = cachedImage as? UIImage {
                self.image = image
                print("Find image on Cache : For Key" , urlString.replacingOccurrences(of: " ", with: "%20"))
                return
            }
        }
        
        print("Conecting to Host with Url:-> \(url)")
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    self.image = placeHolder
                    return
                }
            }
            if data == nil {
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    iimageCache.removeAllObjects()
                    self.image = image
                    iimageCache.setObject(image, forKey: urlString.replacingOccurrences(of: " ", with: "%20") as NSString)
                }
            }
        }).resume()
    }
}


public enum kHTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}


public enum ErrorType: Error {
    case noNetwork, requestSuccess, requestFailed, requestCancelled
}



public class TANetworkManager {
    
    // MARK: - Properties
    
    /**
     A shared instance of `Manager`, used by top-level Alamofire request methods, and suitable for use directly
     for any ad hoc requests.
     */
    
    
    
    //Old Instanse
    
    
    internal static let sharedInstance: TANetworkManager = {
        return TANetworkManager()
    }()
    
    
    var customDelegate : TANetworkManagerDelegate?
    
    // MARK:- Public Method
    /**
     *  Initiates HTTPS or HTTP request over |kHTTPMethod| method and returns call back in success and failure block.
     *
     *  @param serviceName  name of the service
     *  @param method       method type like Get and Post
     *  @param postData     parameters
     *  @param responeBlock call back in block
     */
    
    func requestApi(withServiceName serviceName: String, requestMethod method: kHTTPMethod, requestParameters postData: Dictionary<String, Any>, withProgressHUD showProgress: Bool, completionClosure:@escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void
    {
        if NetworkReachabilityManager()?.isReachable == true
        {
            if showProgress
            {
                showProgressHUD()
            }
            
            let headers = getHeaderWithAPIName(serviceName: serviceName)
            
            let serviceUrl = getServiceUrl(string: serviceName)
            
            let params  = getPrintableParamsFromJson(postData: postData)
            
            print_debug(items: "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
            
            //NSAssert Statements
            assert(method != .GET || method != .POST, "kHTTPMethod should be one of kHTTPMethodGET|kHTTPMethodPOST|kHTTPMethodPOSTMultiPart.");
            
            switch method
            {
            case .GET:
                Alamofire.request(serviceUrl, method: .get, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            if DataResponse.response?.statusCode == 401 { // 401: Token Expired
                               showAlertMessage.alert(message: AlertMessage.kSessionExpired)
                              kSharedUserDefaults.setUserLoggedIn(userLoggedIn: false)
//                              kSharedAppDelegate?.moveToLogin()
                            } else {
                                let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                            }
                            
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            if error.localizedDescription == "cancelled"
                            {
                                completionClosure(nil, error, .requestCancelled, Int.getInt(DataResponse.response?.statusCode))
                            }
                            else
                            {
                                completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                            }
                        }
                })
            case .POST:
                Alamofire.request(serviceUrl, method: .post, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            if DataResponse.response?.statusCode == 401 { // 401: Token Expired
                                showAlertMessage.alert(message: AlertMessage.kSessionExpired)
                                kSharedUserDefaults.setUserLoggedIn(userLoggedIn: false)
//                                kSharedAppDelegate?.moveToLogin()
                            } else {
                                let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                            }
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            case .PUT:
                Alamofire.request(serviceUrl, method: .put, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            case .PATCH:
                Alamofire.request(serviceUrl, method: .patch, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
                
            case .DELETE:
                Alamofire.request(serviceUrl, method: .delete, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            }
        }
        else
        {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, nil)
        }
    }
    
    
    func requestApi1(withServiceName serviceName: String, requestMethod method: kHTTPMethod, requestParameters postData: Dictionary<String, Any>, withProgressHUD showProgress: Bool, completionClosure:@escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void
        {
            if NetworkReachabilityManager()?.isReachable == true
            {
                if showProgress
                {
                    showProgressHUD()
                }
                
                let headers = getHeaderWithAPIName1(serviceName: serviceName)
                
                let serviceUrl = getServiceUrl(string: serviceName)
                
                let params  = getPrintableParamsFromJson(postData: postData)
                
                print_debug(items: "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
                
                //NSAssert Statements
                assert(method != .GET || method != .POST, "kHTTPMethod should be one of kHTTPMethodGET|kHTTPMethodPOST|kHTTPMethodPOSTMultiPart.");
                
                switch method
                {
                case .GET:
                    Alamofire.request(serviceUrl, method: .get, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                        { (DataResponse) in
                            SVProgressHUD.dismiss()
                            switch DataResponse.result
                            {
                            case .success(let JSON):
                                
                                print_debug_fake(items: "Success with JSON: \(JSON)")
                                print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                                if DataResponse.response?.statusCode == 401 { // 401: Token Expired
                                   showAlertMessage.alert(message: AlertMessage.kSessionExpired)
                                  kSharedUserDefaults.setUserLoggedIn(userLoggedIn: false)
    //                              kSharedAppDelegate?.moveToLogin()
                                } else {
                                    let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                    completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                                }
                                
                            case .failure(let error):
                                print_debug(items: "json error: \(error.localizedDescription)")
                                if error.localizedDescription == "cancelled"
                                {
                                    completionClosure(nil, error, .requestCancelled, Int.getInt(DataResponse.response?.statusCode))
                                }
                                else
                                {
                                    completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                                }
                            }
                    })
                case .POST:
                    Alamofire.request(serviceUrl, method: .post, parameters: postData, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON(completionHandler:
                        { (DataResponse) in
                            SVProgressHUD.dismiss()
                            switch DataResponse.result
                            {
                            case .success(let JSON):
                                print_debug_fake(items: "Success with JSON: \(JSON)")
                                print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                                if DataResponse.response?.statusCode == 401 { // 401: Token Expired
                                    showAlertMessage.alert(message: AlertMessage.kSessionExpired)
                                    kSharedUserDefaults.setUserLoggedIn(userLoggedIn: false)
    //                                kSharedAppDelegate?.moveToLogin()
                                } else {
                                    let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                    completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                                }
                            case .failure(let error):
                                print_debug(items: "json error: \(error.localizedDescription)")
                                completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                            }
                    })
                case .PUT:
                    Alamofire.request(serviceUrl, method: .put, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                        { (DataResponse) in
                            SVProgressHUD.dismiss()
                            switch DataResponse.result
                            {
                            case .success(let JSON):
                                print_debug_fake(items: "Success with JSON: \(JSON)")
                                print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                                let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                            case .failure(let error):
                                print_debug(items: "json error: \(error.localizedDescription)")
                                completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                            }
                    })
                case .PATCH:
                    Alamofire.request(serviceUrl, method: .patch, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                        { (DataResponse) in
                            SVProgressHUD.dismiss()
                            switch DataResponse.result
                            {
                            case .success(let JSON):
                                print_debug_fake(items: "Success with JSON: \(JSON)")
                                print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                                let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                            case .failure(let error):
                                print_debug(items: "json error: \(error.localizedDescription)")
                                completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                            }
                    })
                    
                case .DELETE:
                    Alamofire.request(serviceUrl, method: .delete, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                        { (DataResponse) in
                            SVProgressHUD.dismiss()
                            switch DataResponse.result
                            {
                            case .success(let JSON):
                                print_debug_fake(items: "Success with JSON: \(JSON)")
                                print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                                let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                            case .failure(let error):
                                print_debug(items: "json error: \(error.localizedDescription)")
                                completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                            }
                    })
                }
            }
            else
            {
                SVProgressHUD.dismiss()
                completionClosure(nil, nil, .noNetwork, nil)
            }
        }
    
    /**
     *  Upload multiple images and videos via multipart
     *
     *  @param serviceName  name of the service
     *  @param imagesArray  array having images in NSData form
     *  @param videosArray  array having videos file path
     *  @param postData     parameters
     *  @param responeBlock call back in block
     */
    func requestMultiPart(withServiceName serviceName: String, requestMethod method: HTTPMethod, requestImages arrImages: [Dictionary<String, Any>], requestVideos arrVideos: Dictionary<String, Any>, requestData postData: Dictionary<String, Any>, completionClosure: @escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            let serviceUrl = getServiceUrl(string: serviceName)
            let params  = getPrintableParamsFromJson(postData: postData)
            let headers = getHeaderWithAPIName(serviceName: serviceName)
            
            print_debug(items: "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
            
            Alamofire.upload(multipartFormData:{ (multipartFormData: MultipartFormData) in
                for (key,value) in postData {
                    
                    if key == "location_id[]" {
                        
                        for loc in kSharedInstance.getStringArray(value) {
                            
                            multipartFormData.append(self.convertToData(loc),withName: key)
                            
                        }
                    } else {
                        
                        multipartFormData.append(self.convertToData(value),withName: key)
                        
                    }
                    
                }
                
                
                let videoDic = kSharedInstance.getDictionary(arrVideos)
                
                if let videoData = videoDic["video"] as? URL {
                    
                    multipartFormData.append(videoData, withName: videoDic["videoName"] as! String,  fileName: "messagevideo.mp4", mimeType: "video/mp4")
                }
                
                
                
                for dictImage in arrImages {
                    let validDict = kSharedInstance.getDictionary(dictImage)
                    
                    if let image = validDict["image"] as? UIImage {
                        if let imageData: Data = image.jpegData(compressionQuality: 0.4) {
                            
                            print(String.getString(validDict["imageName"]),imageData)
                            
                            multipartFormData.append(imageData, withName: String.getString(validDict["imageName"]), fileName: String.getString(NSNumber.getNSNumber(message: self.getCurrentTimeStamp()).intValue) + ".jpeg", mimeType: "image/jpeg")
                        }
                  }// else if let image  = validDict["image"] as? [UIImage]  {
//                          let imageArr = kSharedInstance.getArray(validDict["image"])
//
//                          if imageArr.count > 0 {
//
//                            for i in 0..<imageArr.count {
//                              if let image = imageArr[i] as? UIImage
//                              {
//                                if let imageData: Data = image.jpegData(compressionQuality: 0.4)                  {
//                                  multipartFormData.append(imageData, withName: String.getString(validDict["imageName"]), fileName: String.getString(NSNumber.getNSNumber(message: self.getCurrentTimeStamp()).intValue) + ".jpeg", mimeType: "image/jpeg")
//                                }
//                              }
//                            }
//                          }
//                        }
                        
                    else if let url = validDict["image"] as? URL {
                        do{
                            let _ = url.startAccessingSecurityScopedResource()
                            if let data = try? Data.init(contentsOf: url) {
                                let pdfData = data
                                print(String.getString(validDict["imageName"]),data)
                                multipartFormData.append(pdfData, withName: String.getString(dictImage["imageName"]), fileName: url.lastPathComponent, mimeType:"application/pdf")
                                
                                url.stopAccessingSecurityScopedResource()
                            }
                        }
//                        catch let error {
//                            url.stopAccessingSecurityScopedResource()
//                            print("error: \(error.localizedDescription)")
//                        }
                        
                    } else {
                        if let urlString = validDict["image"] as? String {
                            if let url = URL.init(string: urlString) {
                                do {
                                    let data = try Data.init(contentsOf: url)
                                    if String.getString(postData[kKey]) == "2" {
                                        multipartFormData.append(data,
                                                                 withName: String.getString(validDict["imageName"]),
                                                                 fileName: String.getString(NSNumber.getNSNumber(message: self.getCurrentTimeStamp()).intValue) + ".mp4",
                                                                 mimeType: "video/mp4")
                                        
                                    } else {
                                        
                                        multipartFormData.append(data, withName: String.getString(validDict["imageName"]), fileName: String.getString(NSNumber.getNSNumber(message: self.getCurrentTimeStamp()).intValue) + "audiofile.m4a", mimeType: "audio/m4a")
                                        
                                    }
                                    
                                } catch {print(error.localizedDescription)}
                            }
                        }
                    }
                    
                }
                
            }, to: serviceUrl, method: method, headers:headers, encodingCompletion: { (encodingResult: SessionManager.MultipartFormDataEncodingResult) in
                switch encodingResult
                {
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON(completionHandler: { (Response) in
                        //  SVProgressHUD.dismiss()
                        let response = self.getResponseDataDictionaryFromData(data: Response.data!)
                        completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(Response.response?.statusCode))
                    })
                case .failure(let error):
                    //  SVProgressHUD.dismiss()
                    completionClosure(nil, error, .requestFailed, 200)
                }
            })
        }
        else
        {

            completionClosure(nil, nil, .noNetwork, nil)
        }
    }
    
    func cancelAllRequests(completionHandler: @escaping () -> ())
    {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { (dataTask: [URLSessionDataTask], uploadTask: [URLSessionUploadTask], downloadTask: [URLSessionDownloadTask]) in
            dataTask.forEach({ (task: URLSessionDataTask) in task.cancel() })
            uploadTask.forEach({ (task: URLSessionUploadTask) in task.cancel() })
            downloadTask.forEach({ (task: URLSessionDownloadTask) in task.cancel() })
            completionHandler()
        }
    }
    
    
    fileprivate func convertToData(_ value:Any) -> Data
    {
        if let str =  value as? String
        {
            return String.getString(str).data(using: String.Encoding.utf8)!
        }
        else if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
        {
            return jsonData
        }
        else
        {
            return Data()
        }
    }
    
    
    // MARK:- Private Method
    private func showProgressHUD() {
       SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.show(withStatus: "Please Wait")
    }
    
    private func getHeaderWithAPIName(serviceName: String) -> [String: String] {
        var headers:[String: String] = [:]
        
        if String.getString(kSharedUserDefaults.getLoggedInAccessToken()) != "" {
            headers["Authorization"] = "Bearer" + " " + kSharedUserDefaults.getLoggedInAccessToken()
            headers["Content-Type"] = "application/json"
        }
        else {
//            headers["Authorization"] = kSharedUserDefaults.getTokenOtp()
//                       headers["Content-Type"] = "application/json"
      //      headers["accessToken"] = ""
    //         headers["Content-Type"] = "application/json"
        }
        
        print_debug(items: "accessToken: \(headers)")
        return headers
    }
    
     private func getHeaderWithAPIName2(serviceName: String) -> [String: String] {
            var headers:[String: String] = [:]
            
            if String.getString(kSharedUserDefaults.getLoggedInAccessToken()) != "" {
                headers["Authorization"] = "Bearer" + " " + kSharedUserDefaults.getLoggedInAccessToken()
                headers["Content-Type"] = "multipart/form-data"
            }
            else {
    //            headers["Authorization"] = kSharedUserDefaults.getTokenOtp()
    //                       headers["Content-Type"] = "application/json"
          //      headers["accessToken"] = ""
        //         headers["Content-Type"] = "application/json"
            }
            
            print_debug(items: "accessToken: \(headers)")
            return headers
        }
    
    
    private func getHeaderWithAPIName1(serviceName: String) -> [String: String] {
           var headers:[String: String] = [:]
           
   
             //  headers["Authorization"] = kSharedUserDefaults.getTokenOtp()
               headers["Content-Type"] = "multipart/form-data"
           
           
           print_debug(items: "accessToken: \(headers)")
           return headers
       }
       
    
    
    
    private func getServiceUrl(string: String) -> String {
        if string.contains("http") {
            return string
        }
        else {
            return kBASEURL + string
        }
    }
    
    private func getPrintableParamsFromJson(postData: Dictionary<String, Any>) -> String
    {
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: postData, options:JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = String(data:jsonData, encoding:String.Encoding.ascii)
            return theJSONText ?? ""
        }
        catch let error as NSError
        {
            print_debug(items: error)
            return ""
        }
    }
    
    private func getResponseDataArrayFromData(data: Data) -> (responseData: [Any]?, error: NSError?)
    {
        do
        {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
            print("Success with JSON: \(String(describing: responseData))")
            return (responseData, nil)
        }
        catch let error as NSError
        {
            print_debug(items: "json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
     func getResponseDataDictionaryFromData(data: Data) -> (responseData: Dictionary<String, Any>?, error: Error?)
    {
        do
        {
            if let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>{
                 print("Success with JSON: \(String(describing: responseData))")
                 return (responseData, nil)
            }else{
                let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Dictionary<String, Any>]
                let dict = ["data" : responseData]
                print("Success with JSON: \(String(describing: dict))")
                return (dict as Dictionary<String, Any>, nil)
            }
        }
        catch let error
        {
            print_debug(items: "json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
    private func printResponseDataForResponse(response: DataResponse<Any>)
    {
        print_debug(items: response.request ?? "")  // original URL request
        print_debug(items: response.response ?? "") // URL response
        print_debug(items: response.data ?? "")     // server data
        print_debug(items: response.result)   // result of response serialization
    }
    
    private func encryptRequestString(requestStr: String)-> String
    {
        return ""
    }
    
    private func getCurrentTimeStamp()-> TimeInterval
    {
        return NSDate().timeIntervalSince1970.rounded();
    }
    
    
    func requestAPI(withServiceName serviceName: String,
                    requestMethod method: kHTTPMethod,
                    requestParameters postData: Dictionary<String, Any>,
                    header: Dictionary<String, String>,
                    completionClosure:@escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void
    {
        if NetworkReachabilityManager()?.isReachable == true
        {
            
            let serviceUrl = getServiceUrl(string: serviceName)
            let params  = getPrintableParamsFromJson(postData: postData)
            
            print_debug(items: "Header: \(header)")
            print_debug(items: "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
            
            //NSAssert Statements
            assert(method != .GET || method != .POST, "kHTTPMethod should be one of kHTTPMethodGET|kHTTPMethodPOST|kHTTPMethodPOSTMultiPart.");
            
            switch method
            {
            case .GET:
                Alamofire.request(serviceUrl, method: .get, parameters: postData, encoding: URLEncoding.default, headers: header).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            if DataResponse.response?.statusCode == 401 { // 401: Token Expired
                                 showAlertMessage.alert(message: AlertMessage.kSessionExpired)
                             //   kSharedSceneDelegate.logOut()
                            } else {
                                let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                            }
                            
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            if error.localizedDescription == "cancelled"
                            {
                                completionClosure(nil, error, .requestCancelled, Int.getInt(DataResponse.response?.statusCode))
                            }
                            else
                            {
                                completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                            }
                        }
                })
            case .POST:
                Alamofire.request(serviceUrl, method: .post, parameters: postData, encoding: JSONEncoding.prettyPrinted, headers: header).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            if DataResponse.response?.statusCode == 401 { // 401: Token Expired
                                showAlertMessage.alert(message: AlertMessage.kSessionExpired)
                              //  kSharedSceneDelegate.logOut()
                            } else {
                                let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                            }
                            
                            
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            case .PUT:
                Alamofire.request(serviceUrl, method: .put, parameters: postData, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            case .PATCH:
                Alamofire.request(serviceUrl, method: .patch, parameters: postData, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
                
            case .DELETE:
                Alamofire.request(serviceUrl, method: .delete, parameters: postData, encoding: URLEncoding.default, headers: header).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            }
        }
        else
        {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, nil)
        }
    }
}

extension TANetworkManager {
    
    //    MARK:- PUBLIC METHODS
    
    public func apiCallNormal(withServiceName serviceName: String, getAppendData: String = "", requestMethod method: kHTTPMethod, requestParameters postData: Dictionary<String, Any>, withProgressHUD showProgress: Bool){
        
        self.requestApi(withServiceName: serviceName,  requestMethod: method, requestParameters: postData, withProgressHUD: showProgress) { (result, error, errorType, statusCode) in
            var response = Dictionary<String,Any>()
            if let response1 = result  as? Dictionary<String,Any> {
                response = response1
            }
            //            print("ERROR:\(error)")
            print("NORMAL RESPONSE :\(response)")
            
            var message = ""
            if let msg = response["message"] as? String{
                message = msg
            }
            
            switch errorType{
            case .noNetwork :
                Indicator.showToast(message: AlertMessage.kNoInternet)
            case .requestCancelled , .requestFailed :
                Indicator.showToast(message: AlertMessage.kInvalidUser)
                self.customDelegate?.failedWithError(error: error!)
            case .requestSuccess :
                switch statusCode{
                case 200,201:
                    self.customDelegate?.dataDidfetched(data: response)
                case 400,401:
                    Indicator.showToast(message: message)
                default :
                    if let msg = response["message"] as? String{
                        message = msg
                        Indicator.showToast(message: msg)
                    }else{
                        break
                    }
                }
                
            }
        }
    }
    
    
    
    public func apiCallMultipart(withServiceName serviceName: String, requestMethod method: HTTPMethod, requestImages arrImages: [Dictionary<String, Any>], requestVideo videoDict: Dictionary<String, Any>, requestData postData: Dictionary<String, Any>){
        
        self.requestMultiPart(withServiceName: serviceName, requestMethod: method, requestImages:arrImages , requestVideos: videoDict, requestData: postData) { (result, error, errorType, statusCode) in
            guard let response = result  as? Dictionary<String,Any> else{
                return
            }
            var message = ""
            if let msg = response["message"] as? String{
                message = msg
            }
            
            switch errorType{
            case .noNetwork :
                Indicator.showToast(message: AlertMessage.kNoInternet)
            case .requestCancelled , .requestFailed :
                Indicator.showToast(message: AlertMessage.kInvalidUser)
                
                self.customDelegate?.failedWithError(error: error!)
            case .requestSuccess :
                switch statusCode{
                case 200,201:
                    
                    self.customDelegate?.dataDidfetched(data: response)
                case 400,401:
                    
                    Indicator.showToast(message: message)
                default :
                    if let msg = response["message"] as? String{
                        message = msg
                        Indicator.showToast(message: msg)
                    }else{
                        break
                    }
                }
            }
        }
    }
    
    
    
    func multipartApi(withServiceName serviceName: String,sendToken : Bool, withMethod method: kHTTPMethod, withParams parametes: [String:Any], withImageParams imageParameters: [String:Any], withProgressHud showProgress: Bool, completion: ((_ result: Any?, _ error: String?,_ statuscode : Int?) -> Void)?) {
        
      //  print("Connecting With Parameters \(parametes)")
       // print("Connecting With Image Parameters \(imageParameters)")
        
        var method1 : HTTPMethod = .post
        
        if NetworkReachabilityManager.init()?.isReachable == true {
            
            self.showProgressHUD()
            var headers = [String : String]()
            let serviceUrl = getServiceUrl(string: serviceName)
            if sendToken{
                headers = getHeaderWithAPIName2(serviceName: serviceName)
                method1 = .patch
            }else{
             headers = getHeaderWithAPIName1(serviceName: serviceName)
            }
            print("serviceURL == \(serviceUrl)")
            
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in parametes {
                    multipartFormData.append(("\(value)").data(using: String.Encoding.utf8)!, withName: key)
                }
                
                if let image = imageParameters["image"] as? UIImage {
                    if let imageData = image.jpegData(compressionQuality: 0.7) {
                        let imageName = imageParameters["imageName"] as? String
                        multipartFormData.append(imageData, withName: imageName ?? "", fileName: "\(String(Int(Date().timeIntervalSince1970))).jpeg", mimeType: "image/jpeg")
                    }
                }
                print(multipartFormData,"MULTI PART FORM DATA")
            }, usingThreshold: UInt64.init(), to: serviceUrl, method: method1, headers: headers) { (result) in
                switch result {
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON(completionHandler: { (responseData) in
                        print("here")
                        var response: [String:Any]? = [:]
                        do {
                            SVProgressHUD.dismiss()
                            response = try JSONSerialization.jsonObject(with: responseData.data!, options: .allowFragments) as? [String:Any]
                            
                          //  print("Success with response Code \(responseData.response?.statusCode ?? 0)")
                          // print("Success with JSON \(response ?? [:])")
                        }
                        catch {
                            SVProgressHUD.dismiss()
                            completion?(nil, error.localizedDescription, 0)
                        }
                        print("here1")
                        
                        let message = response?["message"] as? String
                        print("here2")
                       print(responseData.response?.statusCode,"STATUS CODE")
                        switch responseData.response?.statusCode {
                        case 200:
                            completion?(response, nil, responseData.response?.statusCode)
                        case 201:
                        completion?(response, nil,responseData.response?.statusCode)
                            case 400:
                            completion?(response, nil,responseData.response?.statusCode)
                        default:
                            SVProgressHUD.dismiss()
                            completion?(nil, message,responseData.response?.statusCode)
                        }
                    })
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    completion?(nil, error.localizedDescription,0)
                }
            }
        } else {
            SVProgressHUD.dismiss()
            completion?(nil, "Please check network connection.",0)
        }
    }
    
}



// MARK:- PROTOCOLs
protocol TANetworkManagerDelegate {
    func dataDidfetched(data: [String:Any])
    func failedWithError(error : Error)
}










