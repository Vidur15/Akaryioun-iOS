//
//  LoanModel.swift
//  Akariyoun
//
//  Created by vidur on 07/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import Foundation

public class LoanModel {
    public var data : LoanDataModel?
    public var message : String?
    public var success : Bool?
    public var response_code : Int?


    required public init?(dictionary: NSDictionary) {

        if (dictionary["data"] != nil) { data = LoanDataModel(dictionary: dictionary["data"] as? [String : Any] ?? [:]) }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        response_code = dictionary["response_code"] as? Int
    }
}

public class LoanDataModel {
    public var government_loans : Government_loans?
    public var corporate_loans : Government_loans?


     public init(dictionary: [String : Any]) {

        if (dictionary["government_loans"] != nil) { government_loans = Government_loans(dictionary: dictionary["government_loans"] as? [String : Any] ?? [:]) }
         if (dictionary["corporate_loans"] != nil) { corporate_loans = Government_loans(dictionary: dictionary["corporate_loans"] as? [String : Any] ?? [:]) }
    }

}

public class Government_loans {
    public var current_page : Int?
    public var data : Array<LoanData>?
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
        self.data =  abc3.map({LoanData.init(dictionary: $0)})
        
  //      if (dictionary["data"] != nil) { data = LoanData.modelsFromDictionaryArray(dictionary["data"] as! NSArray) }
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

public class LoanData {
    public var id : Int?
    public var image : String?
    public var link : String?
    public var active : Int?
    public var created_at : String?
    public var updated_at : String?


     public init(dictionary: [String : Any]) {

        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        link = dictionary["link"] as? String
        active = dictionary["active"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
    }

}
