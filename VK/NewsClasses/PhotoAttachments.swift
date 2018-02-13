//
//  PhotoAttachments.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 19.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//


import Foundation


class PhotoAttachments {
    let photo604: String
    let photo130: String
    let text: String
    init (photoAttach: JSON) {
        self.photo130 = photoAttach["photo_130"].stringValue
        self.photo604 = photoAttach["photo_604"].stringValue
        self.text = photoAttach["text"].stringValue
        print(self.photo130)
    }
}
