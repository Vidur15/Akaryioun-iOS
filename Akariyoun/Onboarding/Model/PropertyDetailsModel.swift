//
//  PropertyDetailsModel.swift
//  Akariyoun
//
//  Created by vidur on 19/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class PropertyDetailsModel {
    public var data : PropertyDetailsDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = PropertyDetailsDataModel(dictionary: dictionary["data"] as! NSDictionary) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }
}

public class PropertyDetailsDataModel {
    public var property : Property1?
    public var svg_url : String?
    public var imagemap : Array<Imagemap>?
    public var street_data : Array<Street_data>?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["property"] != nil) { property = Property1(dictionary: dictionary["property"] as! NSDictionary) }
        
        let abc1 = dictionary["imagemap"] as? [[String:Any]] ?? []
        self.imagemap =  abc1.map({Imagemap.init(dictionary: $0)})
        
     
        
        let abc2 = dictionary["street_data"] as? [[String:Any]] ?? []
        self.street_data =  abc2.map({Street_data.init(dictionary: $0)})
        
        
        svg_url = dictionary["svg_url"] as? String
      //  if (dictionary["imagemap"] != nil) { imagemap = Imagemap.modelsFromDictionaryArray(dictionary["imagemap"] as! NSArray) }
      //  if (dictionary["street_data"] != nil) { street_data = Street_data.modelsFromDictionaryArray(dictionary["street_data"] as! NSArray) }
    }
}

public class Image_map {
    public var id : Int?
    public var x1 : String?
    public var y1 : String?
    public var x2 : String?
    public var y2 : String?
    public var w : String?
    public var h : String?
    public var area : Int?
    public var city : Int?
    public var member : String?
    public var type : Int?
    public var east : String?
    public var west : String?
    public var north : String?
    public var south : String?
    public var blockNum : Int?
    public var notes : String?
    public var land_num : String?
    public var sector_num : String?
    public var geo : String?


    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        x1 = dictionary["x1"] as? String
        y1 = dictionary["y1"] as? String
        x2 = dictionary["x2"] as? String
        y2 = dictionary["y2"] as? String
        w = dictionary["w"] as? String
        h = dictionary["h"] as? String
        area = dictionary["area"] as? Int
        city = dictionary["city"] as? Int
        member = dictionary["member"] as? String
        type = dictionary["type"] as? Int
        east = dictionary["east"] as? String
        west = dictionary["west"] as? String
        north = dictionary["north"] as? String
        south = dictionary["south"] as? String
        blockNum = dictionary["blockNum"] as? Int
        notes = dictionary["notes"] as? String
        land_num = dictionary["land_num"] as? String
        sector_num = dictionary["sector_num"] as? String
        geo = dictionary["geo"] as? String
    }
}
public class Imagemap {
    public var id : Int?
    public var area : Int?
    public var x1 : String?
    public var y1 : String?
    public var x2 : String?
    public var y2 : String?
    public var w : String?
    public var h : String?
    public var blockNum : Int?
    public var land_num : String?
    public var sector_num : String?
    public var property_exist : Int?

     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        area = dictionary["area"] as? Int
        x1 = dictionary["x1"] as? String
        y1 = dictionary["y1"] as? String
        x2 = dictionary["x2"] as? String
        y2 = dictionary["y2"] as? String
        w = dictionary["w"] as? String
        h = dictionary["h"] as? String
        blockNum = dictionary["blockNum"] as? Int
        land_num = dictionary["land_num"] as? String
        sector_num = dictionary["sector_num"] as? String
        property_exist = dictionary["property_exist"] as? Int
    }

}

public class Property_land_info {
    public var id : Int?
    public var image_map : Image_map?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        if (dictionary["image_map"] != nil) { image_map = Image_map(dictionary: dictionary["image_map"] as! NSDictionary) }
    }

}
public class Property1 {
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
    public var advertising_method : Int?
    public var tambourine_method : String?
    public var featured_image : String?
    public var active : Int?
    public var somme : String?
    public var created_at : String?
    public var updated_at : String?
    public var property_land_info : Array<Property_land_info>?
    public var images : Array<Images>?
    public var member : Member?


    required public init?(dictionary: NSDictionary) {

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
        advertising_method = dictionary["advertising_method"] as? Int
        tambourine_method = dictionary["tambourine_method"] as? String
        featured_image = dictionary["featured_image"] as? String
        active = dictionary["active"] as? Int
        somme = dictionary["somme"] as? String
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        
        
        
        let abc1 = dictionary["property_land_info"] as? [[String:Any]] ?? []
        self.property_land_info =  abc1.map({Property_land_info.init(dictionary: $0)})
        
     
        
        let abc2 = dictionary["images"] as? [[String:Any]] ?? []
        self.images =  abc2.map({Images.init(dictionary: $0)})
        
        if (dictionary["member"] != nil) { member = Member(dictionary: dictionary["member"] as? [String : Any] ?? [:]) }
    }

}
public class Street_data {
    public var id : Int?
    public var st_name_en : String?
    public var st_name_ar : String?
    public var st_width : Int?
    public var st_id : String?
    public var style_attr : String?
    public var area : Int?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        st_name_en = dictionary["st_name_en"] as? String
        st_name_ar = dictionary["st_name_ar"] as? String
        st_width = dictionary["st_width"] as? Int
        st_id = dictionary["st_id"] as? String
        style_attr = dictionary["style_attr"] as? String
        area = dictionary["area"] as? Int
    }

}
