//
//  JSONLoader.swift
//  Parse JSON API
//
//  Created by Ismail on 2022-04-28.
//

import Foundation

class JSONLoader{
        
    
    var categories: Categories?
    let apiURL = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
       
    
    func jsonPasing(competionHandler: @escaping (Categories) -> Void){
        
        let task = URLSession.shared.dataTask(with: apiURL) {(data, response, error) in
            
            guard let data = data else {
                return
            }
            do{
                let categories = try JSONDecoder().decode(Categories.self, from: data)
                DispatchQueue.main.async {
                    competionHandler(categories)
                }
                

                
                
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
}
