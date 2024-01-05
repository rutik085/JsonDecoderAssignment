//
//  University.swift
//  JsonDecoderAssignment
//
//  Created by Mac on 05/01/24.
//

import Foundation
struct University {
    
    var page : Int
    var per_page : Int
    var total : Int
    var total_pages : Int
    var data : [Datas]
}
struct Datas{
    var id : Int
    var first_name : String
    var last_name : String
    var avatar : String
    var email : String
}
