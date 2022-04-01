//
//  MemberDetailsModel.swift
//  Akariyoun
//
//  Created by vidur on 01/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class MemberDetailsModel {
    public var data : MemberDetailsDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = MemberDetailsDataModel(dictionary: dictionary["data"] as? [String : Any] ?? [:]) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }
}

public class MemberDetailsDataModel {
    public var member : Member2?


     public init(dictionary: [String : Any]) {

        if (dictionary["member"] != nil) { member = Member2(dictionary: dictionary["member"] as? [String : Any] ?? [:]) }
    }
}


public class Offers {
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
    }
}
public class Real_state {
    public var id : Int?
    public var title : String?
    public var title_ar : String?
    public var price : Int?
    public var price_ar : Int?
    public var offer_price : Int?
    public var offer_price_ar : Int?
    public var offer_duration : String?
    public var offer_duration_ar : String?
    public var member_number : String?
    public var property_for : String?
    public var property_for_ar : String?
    public var property_option : String?
    public var property_option_ar : String?
    public var property_type : String?
    public var property_type_ar : String?
    public var location : String?
    public var total_land_area : String?
    public var total_land_area_ar : String?
    public var structure_surface_area : String?
    public var structure_surface_area_ar : String?
    public var land_north : String?
    public var land_south : String?
    public var land_east : String?
    public var land_west : String?
    public var land_m_north : String?
    public var land_m_south : String?
    public var land_m_east : String?
    public var land_m_west : String?
    public var description : String?
    public var description_ar : String?
    public var floors : String?
    public var beds : String?
    public var baths : String?
    public var maid_room : String?
    public var kitchen : String?
    public var garage_capacity : String?
    public var property_age : String?
    public var swimming_pool : String?
    public var out_house : String?
    public var total_units : String?
    public var active : Int?
    public var created_at : String?
    public var updated_at : String?
    public var images : Array<Images>?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        title = dictionary["title"] as? String
        title_ar = dictionary["title_ar"] as? String
        price = dictionary["price"] as? Int
        price_ar = dictionary["price_ar"] as? Int
        offer_price = dictionary["offer_price"] as? Int
        offer_price_ar = dictionary["offer_price_ar"] as? Int
        offer_duration = dictionary["offer_duration"] as? String
        offer_duration_ar = dictionary["offer_duration_ar"] as? String
        member_number = dictionary["member_number"] as? String
        property_for = dictionary["property_for"] as? String
        property_for_ar = dictionary["property_for_ar"] as? String
        property_option = dictionary["property_option"] as? String
        property_option_ar = dictionary["property_option_ar"] as? String
        property_type = dictionary["property_type"] as? String
        property_type_ar = dictionary["property_type_ar"] as? String
        location = dictionary["location"] as? String
        total_land_area = dictionary["total_land_area"] as? String
        total_land_area_ar = dictionary["total_land_area_ar"] as? String
        structure_surface_area = dictionary["structure_surface_area"] as? String
        structure_surface_area_ar = dictionary["structure_surface_area_ar"] as? String
        land_north = dictionary["land_north"] as? String
        land_south = dictionary["land_south"] as? String
        land_east = dictionary["land_east"] as? String
        land_west = dictionary["land_west"] as? String
        land_m_north = dictionary["land_m_north"] as? String
        land_m_south = dictionary["land_m_south"] as? String
        land_m_east = dictionary["land_m_east"] as? String
        land_m_west = dictionary["land_m_west"] as? String
        description = dictionary["description"] as? String
        description_ar = dictionary["description_ar"] as? String
        floors = dictionary["floors"] as? String
        beds = dictionary["beds"] as? String
        baths = dictionary["baths"] as? String
        maid_room = dictionary["maid_room"] as? String
        kitchen = dictionary["kitchen"] as? String
        garage_capacity = dictionary["garage_capacity"] as? String
        property_age = dictionary["property_age"] as? String
        swimming_pool = dictionary["swimming_pool"] as? String
        out_house = dictionary["out_house"] as? String
        total_units = dictionary["total_units"] as? String
        active = dictionary["active"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        
        let abc1 = dictionary["images"] as? [[String:Any]] ?? []
        self.images =  abc1.map({Images.init(dictionary: $0)})
        
     //   if (dictionary["images"] != nil) { images = Images.modelsFromDictionaryArray(dictionary["images"] as! NSArray) }
    }

}
public class Member2 {
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
    public var facebook_url : String?
    public var twitter_url : String?
    public var linkedin_url : String?
    public var created_at : String?
    public var cover_photo : String?
    public var member_since : String?
    public var info : Info?
    public var real_state : Array<Real_state>?
    public var requests : Array<Requests1>?
    public var offers : Array<Offers>?


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
        facebook_url = dictionary["facebook_url"] as? String
        twitter_url = dictionary["twitter_url"] as? String
        linkedin_url = dictionary["linkedin_url"] as? String
        created_at = dictionary["created_at"] as? String
        cover_photo = dictionary["cover_photo"] as? String
        member_since = dictionary["member_since"] as? String
        
        if (dictionary["info"] != nil) { info = Info(dictionary: dictionary["info"] as? [String : Any] ?? [:]) }
        
        let abc1 = dictionary["real_state"] as? [[String:Any]] ?? []
        self.real_state =  abc1.map({Real_state.init(dictionary: $0)})
        
        let abc2 = dictionary["requests"] as? [[String:Any]] ?? []
        self.requests =  abc2.map({Requests1.init(dictionary: $0)})
        
        let abc3 = dictionary["offers"] as? [[String:Any]] ?? []
        self.offers =  abc3.map({Offers.init(dictionary: $0)})
        
    //    if (dictionary["real_state"] != nil) { real_state = Real_state.modelsFromDictionaryArray(dictionary["real_state"] as! NSArray) }
    //    if (dictionary["requests"] != nil) { requests = Requests.modelsFromDictionaryArray(dictionary["requests"] as! NSArray) }
   //     if (dictionary["offers"] != nil) { offers = Offers.modelsFromDictionaryArray(dictionary["offers"] as! NSArray) }
    }

        

}
public class Info {
    public var id : Int?
    public var who_we_are : String?
    public var who_we_are_ar : String?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        who_we_are = dictionary["who_we_are"] as? String
        who_we_are_ar = dictionary["who_we_are_ar"] as? String
    }
}
public class Requests1 {
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
    }
}
