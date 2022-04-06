//
//  NewsModel.swift
//  Akariyoun
//
//  Created by vidur on 06/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class NewsModel {
    public var data : NewsDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = NewsDataModel(dictionary: dictionary["data"] as! NSDictionary) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }

}

public class NewsDataModel {
    public var news : News?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["news"] != nil) { news = News(dictionary: dictionary["news"] as! NSDictionary) }
    }
}
public class News {
    public var current_page : Int?
    public var data : Array<Requests1>?
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


    required public init?(dictionary: NSDictionary) {

        current_page = dictionary["current_page"] as? Int
        
        let abc = dictionary["data"] as? [[String:Any]] ?? []
        self.data =  abc.map({Requests1.init(dictionary: $0)})
        
    //    if (dictionary["data"] != nil) { data = Requests1.modelsFromDictionaryArray(dictionary["data"] as! NSArray) }
        
        first_page_url = dictionary["first_page_url"] as? String
        from = dictionary["from"] as? Int
        last_page = dictionary["last_page"] as? Int
        last_page_url = dictionary["last_page_url"] as? String
        
        let abc3 = dictionary["links"] as? [[String:Any]] ?? []
        self.links =  abc3.map({Links.init(dictionary: $0)})
        
        
   //     if (dictionary["links"] != nil) { links = Links.modelsFromDictionaryArray(dictionary["links"] as! NSArray) }
        
        next_page_url = dictionary["next_page_url"] as? String
        path = dictionary["path"] as? String
        per_page = dictionary["per_page"] as? Int
        prev_page_url = dictionary["prev_page_url"] as? String
        to = dictionary["to"] as? Int
        total = dictionary["total"] as? Int
    }
}
