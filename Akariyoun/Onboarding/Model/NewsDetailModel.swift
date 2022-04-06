//
//  NewsDetailModel.swift
//  Akariyoun
//
//  Created by vidur on 06/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class NewsDetailModel {
    public var data : NewsDetailDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = NewsDetailDataModel(dictionary: dictionary["data"] as? [String : Any] ?? [:]) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }

}

public class NewsDetailDataModel {
    public var news : News1?
    public var related_news : Array<Related_news>?


     public init(dictionary: [String : Any]) {

        if (dictionary["news"] != nil) { news = News1(dictionary: dictionary["news"] as? [String : Any] ?? [:]) }
        
        let abc3 = dictionary["related_news"] as? [[String:Any]] ?? []
        self.related_news =  abc3.map({Related_news.init(dictionary: $0)})
        
     //   if (dictionary["related_news"] != nil) { related_news = Related_news.modelsFromDictionaryArray(dictionary["related_news"] as! NSArray) }
    }

}
public class News1 {
    public var id : Int?
    public var image : String?
    public var title : String?
    public var title_ar : String?
    public var description : String?
    public var description_ar : String?
    public var active : Int?
    public var created_at : String?
    public var updated_at : String?

    public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        title = dictionary["title"] as? String
        title_ar = dictionary["title_ar"] as? String
        description = dictionary["description"] as? String
        description_ar = dictionary["description_ar"] as? String
        active = dictionary["active"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
    }

}
public class Related_news {
    public var id : Int?
    public var image : String?
    public var title : String?
    public var title_ar : String?
    public var description : String?
    public var description_ar : String?
    public var active : Int?
    public var created_at : String?
    public var updated_at : String?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        title = dictionary["title"] as? String
        title_ar = dictionary["title_ar"] as? String
        description = dictionary["description"] as? String
        description_ar = dictionary["description_ar"] as? String
        active = dictionary["active"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
    }

}
