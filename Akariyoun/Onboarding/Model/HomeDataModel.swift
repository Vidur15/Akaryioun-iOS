//
//  HomeDataModel.swift
//  Akariyoun
//
//  Created by vidur on 26/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class HomeDataModel {
    
    public var type : String?
    public var features : Array<Features>?

    required public init?(dictionary: NSDictionary) {

        type = dictionary["type"] as? String
        
        let abc1 = dictionary["features"] as? [[String:Any]] ?? []
        self.features =  abc1.map({Features.init(dictionary: $0)})
        
     //   if (dictionary["features"] != nil) { features = Features.modelsFromDictionaryArray(dictionary["features"] as! NSArray) }
    }
}

public class Features {
    public var type : String?
    public var properties : Properties?
    public var geometry : Geometry?


     public init(dictionary: [String : Any]) {

        type = dictionary["type"] as? String
        if (dictionary["properties"] != nil) { properties = Properties(dictionary: dictionary["properties"] as! NSDictionary) }
        if (dictionary["geometry"] != nil) { geometry = Geometry(dictionary: dictionary["geometry"] as! NSDictionary) }
    }
}

public class Geometry {
    public var type : String?
    public var coordinates : Array<Array<Array<Double>>>?


    required public init?(dictionary: NSDictionary) {

        type = dictionary["type"] as? String
        
        coordinates = dictionary["coordinates"] as? [[[Double]]] ?? [[]]
        
    //    if (dictionary["coordinates"] != nil) { coordinates = Coordinates.modelsFromDictionaryArray(dictionary["coordinates"] as! NSArray) }
    }
}

public class Properties {
    public var id : Int?
    public var dist_ar : String?
    public var dist_en : String?
    public var area_code : String?
    public var point_x : Int?
    public var point_y : Int?
    public var north_area : String?
    public var south_area : String?
    public var east_area : String?
    public var west_area : String?
    public var color : String?
    public var city_id : Int?


    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        dist_ar = dictionary["dist_ar"] as? String
        dist_en = dictionary["dist_en"] as? String
        area_code = dictionary["area_code"] as? String
        point_x = dictionary["point_x"] as? Int
        point_y = dictionary["point_y"] as? Int
        north_area = dictionary["north_area"] as? String
        south_area = dictionary["south_area"] as? String
        east_area = dictionary["east_area"] as? String
        west_area = dictionary["west_area"] as? String
        color = dictionary["color"] as? String
        city_id = dictionary["city_id"] as? Int
    }

}
