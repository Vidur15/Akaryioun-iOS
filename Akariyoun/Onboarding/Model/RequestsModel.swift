//
//  RequestsModel.swift
//  Akariyoun
//
//  Created by vidur on 31/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation
public class RequestsModel {
    public var data : RequestsDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = RequestsDataModel(dictionary: dictionary["data"] as? [String : Any] ?? [:]) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }
}
public class RequestsDataModel {
    public var requests : Requests?


     public init(dictionary: [String : Any]) {

        if (dictionary["requests"] != nil) { requests = Requests(dictionary: dictionary["requests"] as? [String : Any] ?? [:]) }
    }
}
public class Requests {
    public var current_page : Int?
    public var data : Array<RequestMainDataModel>?
    public var first_page_url : String?
    public var from : Int?
    public var last_page : Int?
    public var last_page_url : String?
    public var links : Array<Links>?
    public var next_page_url : String?
    public var path : String?
    public var per_page : Int?
    public var prev_page_url : String?
    public var to : Int?
    public var total : Int?


     public init(dictionary: [String : Any]) {

        current_page = dictionary["current_page"] as? Int
        
        let abc1 = dictionary["data"] as? [[String:Any]] ?? []
        self.data =  abc1.map({RequestMainDataModel.init(dictionary: $0)})
        
   //     if (dictionary["data"] != nil) { data = Data.modelsFromDictionaryArray(dictionary["data"] as! NSArray) }
        
        
        first_page_url = dictionary["first_page_url"] as? String
        from = dictionary["from"] as? Int
        last_page = dictionary["last_page"] as? Int
        last_page_url = dictionary["last_page_url"] as? String
        
        let abc2 = dictionary["links"] as? [[String:Any]] ?? []
        self.links =  abc2.map({Links.init(dictionary: $0)})
     //   if (dictionary["links"] != nil) { links = Links.modelsFromDictionaryArray(dictionary["links"] as! NSArray) }
        
        
        next_page_url = dictionary["next_page_url"] as? String
        path = dictionary["path"] as? String
        per_page = dictionary["per_page"] as? Int
        prev_page_url = dictionary["prev_page_url"] as? String
        to = dictionary["to"] as? Int
        total = dictionary["total"] as? Int
    }
}

public class RequestMainDataModel {
    public var id : Int?
    public var type : Int?
    public var active : Int?
    public var status : String?
    public var title : String?
    public var description : String?
    public var title_ar : String?
    public var description_ar : String?
    public var created_at : String?
    public var updated_at : String?
    public var user : User?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        type = dictionary["type"] as? Int
        active = dictionary["active"] as? Int
        status = dictionary["status"] as? String
        title = dictionary["title"] as? String
        description = dictionary["description"] as? String
        title_ar = dictionary["title_ar"] as? String
        description_ar = dictionary["description_ar"] as? String
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        
        if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as? [String : Any] ?? [:]) }
    }
}
public class User {
    public var id : String?
    public var first_name : String?
    public var first_name_ar : String?
    public var last_name : String?
    public var last_name_ar : String?
    public var email : String?
    public var mobile_number : String?
    public var profile_pic : String?
    public var cover_photo : String?
    public var facebook_url : String?
    public var twitter_url : String?
    public var linkedin_url : String?
    public var member_since : String?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? String
        first_name = dictionary["first_name"] as? String
        first_name_ar = dictionary["first_name_ar"] as? String
        last_name = dictionary["last_name"] as? String
        last_name_ar = dictionary["last_name_ar"] as? String
        email = dictionary["email"] as? String
        mobile_number = dictionary["mobile_number"] as? String
        profile_pic = dictionary["profile_pic"] as? String
        cover_photo = dictionary["cover_photo"] as? String
        facebook_url = dictionary["facebook_url"] as? String
        twitter_url = dictionary["twitter_url"] as? String
        linkedin_url = dictionary["linkedin_url"] as? String
        member_since = dictionary["member_since"] as? String
    }
}
