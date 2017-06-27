//
//  Convert.swift
//  WeatherApp
//
//  Created by Dung on 6/26/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import Foundation

class ConvertHelper {
    fileprivate static let arrCoDau: [Character] =
        ["á","à","ả","ã","ạ",
         "ă","ắ","ằ","ẳ","ẵ","ặ",
         "â","ấ","ầ","ẩ","ẫ","ậ",
         "đ",
         "é","è","ẻ","ẽ","ẹ",
         "ê","ế","ề","ể","ễ","ệ",
         "í","ì","ỉ","ĩ","ị",
         "ó","ò","ỏ","õ","ọ",
         "ô","ố","ồ","ổ","ỗ","ộ",
         "ơ","ớ","ờ","ở","ỡ","ợ",
         "ú","ù","ủ","ũ","ụ",
         "ư","ứ","ừ","ử","ữ","ự",
         "ý","ỳ","ỷ","ỹ","ỵ",
         
         "Á","À","Ả","Ã","Ạ",
         "Ă","Ắ","Ằ","Ẳ","Ẵ","Ặ",
         "Â","Ấ","Ầ","Ẩ","Ẫ","Ậ",
         "Đ",
         "É","È","Ẻ","Ẽ","Ẹ",
         "Ê","Ế","Ề","Ể","Ễ","Ệ",
         "Í","Ì","Ỉ","Ĩ","Ị",
         "Ó","Ò","Ỏ","Õ","Ọ",
         "Ô","Ố","Ồ","Ổ","Ỗ","Ộ",
         "Ơ","Ớ","Ờ","Ở","Ỡ","Ợ",
         "Ú","Ù","Ủ","Ũ","Ụ",
         "Ư","Ứ","Ừ","Ử","Ữ","Ự",
         "Ý","Ỳ","Ỷ","Ỹ","Ỵ"]
    
    fileprivate static let arrKhongDau: [Character] =
        ["a","a","a","a","a",
         "a","a","a","a","a","a",
         "a","a","a","a","a","a",
         "d",
         "e","e","e","e","e",
         "e","e","e","e","e","e",
         "i","i","i","i","i",
         "o","o","o","o","o",
         "o","o","o","o","o","o",
         "o","o","o","o","o","o",
         "u","u","u","u","u",
         "u","u","u","u","u","u",
         "y","y","y","y","y",
         
         "A","A","A","A","A",
         "A","A","A","A","A","A",
         "A","A","A","A","A","A",
         "D",
         "E","E","E","E","E",
         "E","E","E","E","E","E",
         "I","I","I","I","I",
         "O","O","O","O","O",
         "O","O","O","O","O","O",
         "O","O","O","O","O","O",
         "U","U","U","U","U",
         "U","U","U","U","U","U",
         "Y","Y","Y","Y","Y"
    ]
    
    class func convertVN(_ text: String) -> String {
        var arr = Array(text.characters)
        for i in 0 ..< arr.count {
            for j in 0 ..< arrCoDau.count {
                if (arr[i] == arrCoDau[j]) {
                    arr[i] = arrKhongDau[j]
                    break
                }
            }
        }
        return String(arr)
    }
}
