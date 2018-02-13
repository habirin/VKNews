//
//  PhotoAttachments.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 19.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//


import Foundation
import SwiftyJSON

class PhotoAttachments {
    let photo604: String
    let photo130: String
    let text: String
    init (photoAttach: JSON) {
        
        self.photo130 = photoAttach["photo_130"].stringValue
        self.photo604 = photoAttach["photo_604"].stringValue
        self.text = photoAttach["text"].stringValue
        
    }
    init (coreDataPhotoAttach: PhotoAttachmentsCD) {
        print(coreDataPhotoAttach.photo130)
        self.photo130 = coreDataPhotoAttach.photo130!
        self.photo604 = coreDataPhotoAttach.photo604!
        self.text = coreDataPhotoAttach.text!
    }
}
