//
//  Model.swift
//  AppStore
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
struct BannerCategory:Codable
{
    var name:String?
    var apps:[App]
    var type:String?
}

struct Featured:Codable {
    var bannerCategory:BannerCategory?
    var categories:[AppCategory]?
    static func fetchFeaturedApps(completionHandler:@escaping (Featured) -> ())
    {
        guard let urlString = URL(string:"https://api.letsbuildthatapp.com/appstore/featured") else{ return}
        URLSession.shared.dataTask(with: urlString,completionHandler:{data,response,error in
            guard let data = data else {return}
            var featuredApps = Featured()
            do
            {
                 featuredApps = try JSONDecoder().decode(Featured.self, from: data)
            }
            catch let error
            {
                print(error.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                completionHandler(featuredApps)
            }
        }).resume()
    }
}

struct AppCategory:Codable
{
    var name:String?
    var apps:[App]?
    var type:String?
}

struct App : Codable {
    let Id:Int?
    let Name:String?
    let Category:String?
    let Price:Float?
    let ImageName:String?
    var Screenshots:[String]?
    var description:String?
}
