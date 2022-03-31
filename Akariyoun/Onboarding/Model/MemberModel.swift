//
//  MemberModel.swift
//  Akariyoun
//
//  Created by vidur on 31/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class MemberModel {
    public var data : MemberDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = MemberDataModel(dictionary: dictionary["data"] as? [String : Any] ?? [:]) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }
}
public class MemberDataModel {
    public var member : Member1?


     public init(dictionary: [String : Any]) {

        if (dictionary["member"] != nil) { member = Member1(dictionary: dictionary["member"] as? [String : Any] ?? [:]) }
    }
}
public class Member1 {
    public var current_page : Int?
    public var data : Array<MemberMainDataModel>?
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
        self.data =  abc1.map({MemberMainDataModel.init(dictionary: $0)})
        
     //   if (dictionary["data"] != nil) { data = MemberMainDataModel.modelsFromDictionaryArray(dictionary["data"] as! NSArray) }
        
        
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
public class MemberMainDataModel {
    public var id : String?
    public var ak_id : String?
    public var first_name : String?
    public var first_name_ar : String?
    public var last_name : String?
    public var last_name_ar : String?
    public var email : String?
    public var user_type : Int?
    public var profile_pic : String?
    public var status : String?
    public var mobile_number : String?
    public var cover_photo : String?
    public var facebook_url : String?
    public var twitter_url : String?
    public var linkedin_url : String?

     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? String
        ak_id = dictionary["ak_id"] as? String
        first_name = dictionary["first_name"] as? String
        first_name_ar = dictionary["first_name_ar"] as? String
        last_name = dictionary["last_name"] as? String
        last_name_ar = dictionary["last_name_ar"] as? String
        email = dictionary["email"] as? String
        user_type = dictionary["user_type"] as? Int
        profile_pic = dictionary["profile_pic"] as? String
        status = dictionary["status"] as? String
        mobile_number = dictionary["mobile_number"] as? String
        cover_photo = dictionary["cover_photo"] as? String
        facebook_url = dictionary["facebook_url"] as? String
        twitter_url = dictionary["twitter_url"] as? String
        linkedin_url = dictionary["linkedin_url"] as? String
    }
}
