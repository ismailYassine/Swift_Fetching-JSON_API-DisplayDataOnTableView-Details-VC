//
//  DataModel.swift
//  Parse JSON API
//
//  Created by Ismail on 2022-04-27.
//

import Foundation

struct Categories: Codable {
    
    var categories: [AcategoryData]
}

struct AcategoryData: Codable {
    
    let idCategory              : String
    let strCategory             : String
    var strCategoryThumb        : String
    var strCategoryDescription  : String
}
