//
//  NetworkClient.swift
//  BasicExample
//
//  Created by Serik on 28.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import Foundation
import Alamofire
//import SwiftKeychainWrapper

final class NetworkClient: NSObject {

    static let sharedInstance: NetworkClient = { return NetworkClient() }()
    
    override private init() {
      super.init()
    }
    
    enum ContentType: String {
        case json = "application/json"
        case form = "application/x-www-form-urlencoded"
        case version = "v1"
    }
    
    enum HTTPHeaderField: String {
        
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case apiVersion = "Api-Version"
    }
    
    let userDefaults = UserDefaults.standard
    
    var isConnectedToInternet: Bool? {
        return NetworkReachabilityManager()?.isReachable
    }
    
    private static var headers: HTTPHeaders {
        return [
            HTTPHeaderField.authorization.rawValue : "Bearer \(AccountManager.getToken() ?? "")",
            HTTPHeaderField.contentType.rawValue: ContentType.form.rawValue,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
            HTTPHeaderField.apiVersion.rawValue: ContentType.version.rawValue
        ]
    }
    
    private var headers: HTTPHeaders {
        return [
            HTTPHeaderField.authorization.rawValue : "Bearer \(AccountManager.getToken() ?? "")",
            HTTPHeaderField.contentType.rawValue: ContentType.form.rawValue,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
            HTTPHeaderField.apiVersion.rawValue: ContentType.version.rawValue
        ]
    }
    
    private var headersJson: HTTPHeaders {
        return [
            HTTPHeaderField.authorization.rawValue : "Bearer \(AccountManager.getToken() ?? "")",
            HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
            HTTPHeaderField.apiVersion.rawValue: ContentType.version.rawValue
        ]
    }
    
    // API
    
    static  let ApiUrlPath                   = "https://api.happycrewapp.com/api/v1"
    private let ClientId                     = "1"
    private let ClientSecret                 = "xTSTQYg5UJDCTtqN12SjIE24durQE7Qlvq7StED8"
    
    // GET
    private let GetInterests                 = "\(ApiUrlPath)/interests"
    private let GetPrivacyPolicy             = "\(ApiUrlPath)/privacy-policy"
    private let GetUserList                  = "\(ApiUrlPath)/users"
    private let GetUser                      = "\(ApiUrlPath)/user/"
    
    // POST
    private let PostToken                    = "\(ApiUrlPath)/oauth/token"
    private let PostRegister                 = "\(ApiUrlPath)/register"
    private let PostLogout                   = "\(ApiUrlPath)/logout"
    private let PostSaveMyProfile            = "\(ApiUrlPath)/user"
    private let PostResetPassword            = "\(ApiUrlPath)/password/reset"
    private let PostCheckEmail               = "\(ApiUrlPath)/check-email"
    private let PostReportContent            = "\(ApiUrlPath)/reports"
    
    // PUT
    private let PutLocation                  = "\(ApiUrlPath)/user/location"
    
    // MARK: - GET
    
    // GetUserList
    func getUserList(nextPage: Int?,
                     perPage: Int?,
                     success: ((ListUsers?) -> Void)?,
                     failure: ErrorCompletion?) {
        
        var url = ""
        if let nextPage = nextPage, let perPage = perPage { // paginations
            url = GetUserList + "?per_page=\(perPage)&log_time_unix=\(Date().timeIntervalSince1970)&page=\(nextPage)"
        } else { // 100 users
            url = GetUserList + "?per_page=100&log_time_unix=\(Date().timeIntervalSince1970)"
        }

        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response { response in
                    
                    // PRINT data
                    self.printResponseData(response)
                    self.printData(response.data)
                    
                    
                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                            return
                    }
                    
                    switch response.result {
                    case .success:
                        let listUsers = self.listUsersMap(data: data)
                        success?(listUsers)
                        break
                        
                    case .failure:
                        self.errorHandler(json: json,
                                          response: response,
                                          success:
                            { (message) in
                                failure?(message)
                        })
                    }
        }
    }
    
    // GetUser
    func getUser(userId: Int?,
                 success: ((User?) -> Void)?,
                 failure: ErrorCompletion?) {
        
        guard let userId = userId else { return}
        let request = GetUser + String(userId)
        
        AF.request(request,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response { response in
                    
                    self.printResponseData(response)

                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                    
                    switch response.result {
                    case .success:
                        let user = self.userMap(data: data)
                        success?(user)
                        break
                        
                    case .failure:
                        self.errorHandler(json: json,
                                          response: response,
                                          success:
                            { (message) in
                                failure?(message)
                        })
                    }
        }
    }
    
    // GetInterests
    func getInterests(success: (([Interest]?) -> Void)?,
                      failure: ErrorCompletion?) {
        
        AF.request(GetInterests,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response { response in
                    
                    self.printResponseData(response)

                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                    
                    switch response.result {
                    case .success:
                        let interests = self.interesMap(data: data)
                        success?(interests)
                        break
                        
                    case .failure:
                        self.errorHandler(json: json,
                                          response: response,
                                          success:
                            { (message) in
                                failure?(message)
                        })
                    }
        }
    }
    
    // GetPrivacyPolicy
    func getPrivacyPolicy(success: (StringCompletion)?,
                          failure: ErrorCompletion?) {
        
        AF.request(GetPrivacyPolicy,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response { response in
                    
                    self.printResponseData(response)

                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                    
                    switch response.result {
                    case .success:
                        
                        if let data = json["data"] as? [String : String], let text: String = data["text"] {
                            success?(text)
                        }
                        break
                        
                    case .failure:
                        self.errorHandler(json: json,
                                          response: response,
                                          success:
                            { (message) in
                                failure?(message)
                        })
                    }
        }
    }
    
    // MARK: - POST
    
    // PostAuthorize
    func postAuthorize(username: String?,
                       password: String?,
                       success: VoidCompletion?,
                       failure: ErrorsCompletion?) {
        
        guard let username = username,
            let password = password else {
                failure?("", "hideSpinner")
                return
        }
        
        let parameters: [String : String] = ["username": username,
                                             "password": password,
                                             "grant_type": "password",
                                             "refresh_token": "",
                                             "client_id": ClientId,
                                             "client_secret": ClientSecret]
        
        AF.request(PostToken,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response { response in
                    
                    self.printResponseData(response)

                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                    
                    switch response.result {
                    case .success:
                        // save Access Token
                        if let apiAccessToken = json["access_token"] as? String, let userId = json["user_id"] as? Int {
                            AccountManager.login(token: apiAccessToken, userId: String(userId))
                        }
                        success?()
                        break
                        
                    case .failure:
                        guard let statusCode = response.response?.statusCode else {
                            failure?("Server error", "")
                            return
                        }
                        
                        Utill.printToConsole("Error StatusCode - \(String(describing: statusCode))")
                        if let error: String = json["error"] as? String,
                            let message: String = json["message"] as? String  {
                            failure?(error, message)
                        }
                    }
        }
    }
    
    // PostRegister
    func postRegister(user: User?,
                      success: UserCompletion?,
                      failure: ErrorCompletion?) {
        
        guard let email = user?.email,
            let password = user?.password,
            let name = user?.name,
            let dateOfBirth = user?.dateOfBirth,
            let gender = user?.gender,
            let interestsIDs = getInterestsIDs(user) else { return }
        
        var imageData: Data!
        if let image = user?.avatar {
            imageData = image.jpegData(compressionQuality: 0.5)
        } else {
            let image = UIImage(named:"placeholder.jpg")
            imageData = image!.jpegData(compressionQuality: 0.5) // placeholder
        }
        
        let parameters: [String : Any] = ["email": email,
                                          "password": password,
                                          "name": name,
                                          "date_of_birth": dateOfBirth,
                                          "gender": gender,
                                          "interests": interestsIDs]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                
                if let values = value as? [String] {
                    for item in values {
                        multipartFormData.append(item.data(using: .utf8)!, withName: key+"[]" )
                    }
                }
                
            }
            multipartFormData.append(imageData,withName: "images[]",
                                     fileName: "swift_file.png",
                                     mimeType: "image/png")
        }, to: PostRegister,
           usingThreshold: UInt64.init(),
           method: .post,
           headers: headersJson).validate(statusCode: 200..<300).response { response in
            
            self.printResponseData(response)

            guard let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
            
            switch response.result {
            case .success:
                if let user = self.userMap(data: data) {
                    success?(user)
                }
                break
                
            case .failure:
                
                guard let statusCode = response.response?.statusCode else { return }
                Utill.printToConsole("Error StatusCode - \(String(describing: statusCode))")
                
                if let message: [String : Any] = json["message"] as? [String : Any] {
                    if let arrayEmail: Array<String>  = message["email"] as? Array<String>,
                        let messageEmail: String = arrayEmail.first {
                        failure?(messageEmail)
                    } else if let arrayName: Array<String>  = message["name"] as? Array<String>,
                        let messageName: String = arrayName.first {
                        failure?(messageName)
                    }
                }
            }
            
        }
    }
    
    // PostRegister
    func reportContent(friendId: String,
                       text: String?,
                       image: UIImage?,
                       description: String,
                       success: (() -> Void)?,
                       failure: StringCompletion?) {
        
        let parameters = ["whom_id": friendId, "content": text, "reason": description]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let value = value {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
            if let imageData = image?.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "content", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
            }
            
        }, to: PostReportContent,
           usingThreshold: UInt64.init(),
           method: .post,
           headers: headersJson).validate(statusCode: 200..<300).response { response in
            
            self.printResponseData(response)

            guard let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
            
            print(json)
            
            switch response.result {
            case .success:
                success?()
                break
                
            case .failure:
                self.errorHandler(json: json, response: response) { message in
                    failure?(message)
                }
            }
        }
    }
    
    // PostLogout
    func postLogout(token: String?,
                    success: VoidCompletion?,
                    failure: ErrorCompletion?) {
        
        let parameters : Parameters? = token != nil ? ["client_device_token": token!] : nil
        
        AF.request(PostLogout,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response { response in
                    
                    self.printResponseData(response)

                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                    
                    switch response.result {
                    case .success:
                        // removeave Access Token
                        AccountManager.logout()
                        success?()
                        break
                        
                    case .failure:
                        self.errorHandler(json: json,
                                          response: response,
                                          success:
                            { (message) in
                                failure?(message)
                        })
                    }
        }
    }
    
    // PostSaveMyProfile
    func postSaveMyProfile(user: User?,
                           success: UserCompletion?,
                           failure: ErrorCompletion?) {
        
        guard let name = user?.name,
            let dateOfBirth = user?.dateOfBirth,
            let interestsIDs = getInterestsIDs(user),
            let gender = user?.gender else { return }
        
        let parameters: [String : Any] = ["name": name,
                                          "date_of_birth": dateOfBirth,
                                          "gender": gender,
                                          "interests": interestsIDs]
        
        var imageData: Data!
        if let image = user?.avatar {
            imageData = image.jpegData(compressionQuality: 0.5)
        } else {
            let image = UIImage(named:"placeholder.jpg")
            imageData = image!.jpegData(compressionQuality: 0.5) // placeholder
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                
                if let values = value as? [String] {
                    for item in values {
                        multipartFormData.append(item.data(using: .utf8)!, withName: key+"[]" )
                    }
                }
                
            }
            multipartFormData.append(imageData,withName: "images[]",
                                     fileName: "swift_file.png",
                                     mimeType: "image/png")
        }, to: PostSaveMyProfile,
           usingThreshold: UInt64.init(),
           method: .post,
           headers: headers).validate(statusCode: 200..<300).response { response in
            
            self.printResponseData(response)

            guard let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
            
            switch response.result {
            case .success:
                if let user = self.userMap(data: data) {
                    success?(user)
                }
                break
                
            case .failure:
                self.errorHandler(json: json,
                                  response: response,
                                  success:
                    { (message) in
                        failure?(message)
                })
            }
        }
    }
    
    // PostResetPassword
    func postResetPassword(email: String?,
                           password: String?,
                           resetCode: String?,
                           success: VoidCompletion?,
                           failure: ErrorCompletion?) {
        
        guard let email = email,
            let password = password,
            let resetCode = resetCode else { return }
        
        let parameters: [String : String] = ["email": email,
                                             "password": password,
                                             "reset_code": resetCode]
        
        AF.request(PostResetPassword,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headersJson).validate(statusCode: 200..<300).response { response in
                    
                    self.printResponseData(response)

                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                    
                    switch response.result {
                    case .success:
                        success?()
                        break
                        
                    case .failure:
                        guard let statusCode = response.response?.statusCode else { return }
                        Utill.printToConsole("Error StatusCode - \(String(describing: statusCode))")
                        
                        if let message: [String : Any] = json["message"] as? [String : Any] {
                            if let arrayEmail: Array<String>  = message["email"] as? Array<String>,
                                let messageEmail: String = arrayEmail.first {
                                failure?(messageEmail)
                            } else if let arrayPassword: Array<String>  = message["password"] as? Array<String>,
                                let messagePassword: String = arrayPassword.first {
                                failure?(messagePassword)
                            }
                        }
                    }
        }
    }
    
    // PostCheckEmail
    func postCheckEmail(email: String?,
                        success: VoidCompletion?,
                        failure: ErrorCompletion?) {
        
        guard let email = email else { return }
        
        let parameters: [String : String] = ["email": email]
        
        AF.request(PostCheckEmail,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headersJson).validate(statusCode: 200..<300).response { response in
                    
                    self.printResponseData(response)

                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                    
                    switch response.result {
                    case .success:
                        success?()
                        break
                        
                    case .failure:
                        guard let statusCode = response.response?.statusCode else {
                            failure?("Server error")
                            return
                        }
                        Utill.printToConsole("Error StatusCode - \(String(describing: statusCode))")
                        if let message: [String : Any] = json["message"] as? [String : Any],
                            let arrayEmail: Array<String>  = message["email"] as? Array<String>,
                            let messageEmail: String = arrayEmail.first {
                            failure?(messageEmail)
                        }
                    }
        }
    }
    
    
    // MARK: - PUT
    
    // PutLocation
    func putLocation(latitude: String?,
                     longitude: String?,
                     success: VoidCompletion?,
                     failure: ErrorCompletion?) {
        
        guard let latitude = latitude,
            let longitude = longitude else {
                return
        }
        
        let parameters: [String : String] = ["lat": latitude, "lng": longitude]
        
        AF.request(PutLocation,
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headersJson).validate(statusCode: 200..<300).response { response in
                    
                    self.printResponseData(response)

                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                            if self.isConnectedToInternet == false {
                                failure?("This app requires an Internet connection")
                            } else {
                                failure?("Not data. Please pull to refresh")
                            }
                            return
                    }
                    
                    switch response.result {
                    case .success:
                        success?()
                        break
                        
                    case .failure:
                        self.errorHandler(json: json,
                                          response: response,
                                          success:
                            { (message) in
                                failure?(message)
                        })
                    }
        }
    }
    
}

// MARK: - MAPPING

extension NetworkClient {
    
    private func interesMap(data: Data?) -> [Interest]? {
        guard let data = data else { return nil }
        let interests: InteresList = try! JSONDecoder().decode(InteresList.self, from: data)
        return interests.data
    }
    
    private func userMap(data: Data?) -> User? {
        guard let data = data else { return nil }
        let user: UserData = try! JSONDecoder().decode(UserData.self, from: data)
        return user.data
    }
    
    private func listUsersMap(data: Data?) -> ListUsers? {
        guard let data = data else { return nil }
        let listUsers: DataListUsers = try! JSONDecoder().decode(DataListUsers.self, from: data)
        return listUsers.data
    }
    
}

// MARK: - InterestsIDs

extension NetworkClient {
    
    private func getInterestsIDs(_ user: User?) -> [String]? {
        
        var interestsIDs = [String]()
        if let interests = user?.interests {
            interests.forEach({
                interestsIDs.append(String($0.id!))
            })
        }
        return interestsIDs
    }
    
}


// MARK: - ERROR HANDLER

extension NetworkClient {
    
    func errorHandler(json: [String : Any],
                      response: AFDataResponse<Data?>,
                      success: StringCompletion?) {
        
        guard let statusCode = response.response?.statusCode,
            let message: String = json["message"] as? String else {
                return
        }
        
        Utill.printToConsole("Error StatusCode - \(String(describing: statusCode))")
        success?(message)
    }
    
}
// MARK: - PRINT

extension NetworkClient {
    
    private func printResponseData(_ response: AFDataResponse<Data?>) {// DataResponse<String>, DefaultDataResponse
        if let data = response.data {
            do {
                let printData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                printData?.forEach { Utill.printToConsole("\($0): \($1)") }
            } catch {
                Utill.printToConsole(error.localizedDescription)
            }
        }
    }
    
    private func printData(_ data: Data?) {
        if let data = data, let JSONSerialization = String(data: data, encoding: .utf8) {
            Utill.printToConsole(JSONSerialization)
        }
    }
    
    
}
