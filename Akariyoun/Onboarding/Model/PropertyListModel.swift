//
//  PropertyListModel.swift
//  Akariyoun
//
//  Created by vidur on 31/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class PropertyListModel {
    public var data : PropertyListDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?



    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = PropertyListDataModel(dictionary: dictionary["data"] as? [String : Any] ?? [:]) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }
}

public class PropertyListDataModel {
    public var property : Property?


     public init(dictionary: [String : Any]) {

        if (dictionary["property"] != nil) { property = Property(dictionary: dictionary["property"] as? [String : Any] ?? [:]) }
    }
}

public class Images {
    public var id : Int?
    public var name : String?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
    }
}
public class Links {
    public var url : String?
    public var label : String?
    public var active : Bool?


    public init(dictionary: [String : Any]) {

        url = dictionary["url"] as? String
        label = dictionary["label"] as? String
        active = dictionary["active"] as? Bool
    }
}
public class Member {
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
    }

}
public class Property {
    public var current_page : Int?
    public var data : Array<MainDataModel>?
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
        self.data =  abc1.map({MainDataModel.init(dictionary: $0)})
    //    if (dictionary["data"] != nil) { data = MainDataModel.modelsFromDictionaryArray(dictionary["data"] as! NSArray) }
        
        
        first_page_url = dictionary["first_page_url"] as? String
        from = dictionary["from"] as? Int
        last_page = dictionary["last_page"] as? Int
        last_page_url = dictionary["last_page_url"] as? String
        
        
        let abc2 = dictionary["links"] as? [[String:Any]] ?? []
        self.links =  abc2.map({Links.init(dictionary: $0)})
    //    if (dictionary["links"] != nil) { links = Links.modelsFromDictionaryArray(dictionary["links"] as! NSArray) }
        
        
        next_page_url = dictionary["next_page_url"] as? String
        path = dictionary["path"] as? String
        per_page = dictionary["per_page"] as? Int
        prev_page_url = dictionary["prev_page_url"] as? String
        to = dictionary["to"] as? Int
        total = dictionary["total"] as? Int
    }
}

public class MainDataModel {
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
    public var member : Member?


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
        
   //     if (dictionary["images"] != nil) { images = Images.modelsFromDictionaryArray(dictionary["images"] as! NSArray) }
        
        
        if (dictionary["member"] != nil) { member = Member(dictionary: dictionary["member"] as? [String : Any] ?? [:]) }
    }

}
