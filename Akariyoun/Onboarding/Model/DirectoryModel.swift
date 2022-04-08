//
//  DirectoryModel.swift
//  Akariyoun
//
//  Created by vidur on 08/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class DirectoryModel {
    public var data : DirectoryDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = DirectoryDataModel(dictionary: dictionary["data"] as? [String : Any] ?? [:]) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }
}

public class DirectoryDataModel {
    public var directories : Directories?


     public init(dictionary: [String : Any]) {

        if (dictionary["directories"] != nil) { directories = Directories(dictionary: dictionary["directories"] as? [String : Any] ?? [:]) }
    }
}

public class Directories {
    public var current_page : Int?
    public var data : Array<DirectoryMainModel>?
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
        
        let abc3 = dictionary["data"] as? [[String:Any]] ?? []
        self.data =  abc3.map({DirectoryMainModel.init(dictionary: $0)})
        
      //  if (dictionary["data"] != nil) { data = DirectoryMainModel.modelsFromDictionaryArray(dictionary["data"] as! NSArray) }
        
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

public class DirectoryMainModel {
    public var id : Int?
    public var office_area_name : String?
    public var office_area_name_ar : String?
    public var office_location : String?
    public var map_url : String?
    public var contact : String?
    public var active : Int?
    public var created_at : String?
    public var updated_at : String?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        office_area_name = dictionary["office_area_name"] as? String
        office_area_name_ar = dictionary["office_area_name_ar"] as? String
        office_location = dictionary["office_location"] as? String
        map_url = dictionary["map_url"] as? String
        contact = dictionary["contact"] as? String
        active = dictionary["active"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
    }
}
