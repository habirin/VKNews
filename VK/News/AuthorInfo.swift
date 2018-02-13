//
//  AuthorInfo.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 21.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//


import Foundation
import SwiftyJSON

class AuthorInfo {
    
    let authorName: String
    let authorScreenName: String
    let authorPhoto50: String
    let authorPhoto100: String
    init(author: JSON) {
        
        switch author {
        case _ where author["last_name"] != nil:
            self.authorName = author["last_name"].stringValue + " " + author["first_name"].stringValue
            
        default: self.authorName = author["name"].stringValue
            
        }
  
        self.authorScreenName = author["screen_name"].stringValue
        self.authorPhoto50 = author["photo_50"].stringValue
        self.authorPhoto100 = author["photo_100"].stringValue
    }
}
