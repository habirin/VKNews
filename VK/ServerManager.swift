//
//  ServerManager.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 15.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct ServerRequest {
    static var newOffset = ""
    static var getNewsFeed: String { return "https://api.vk.com/method/newsfeed.get?v=5.52&start_from=\(ServerManager.myServerManager.nextFrom)&count=16&access_token=\(ServerManager.myServerManager.accessToken)" }
    
}
class ServerManager {
    static var myServerManager: ServerManager!
    let accessToken: String
    var nextFrom = ""
    func doRequest(serverRequest: String, completitionHandler: @escaping (_ response: JSON) -> ())  {
        
        request(serverRequest).responseJSON  { (response) in
            completitionHandler(JSON(response.value))
            
        }
    }
    
    
    init(accessToken: String) {
        self.accessToken = accessToken
        ServerManager.myServerManager = self
    }
    
}
