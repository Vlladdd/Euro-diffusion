//
//  country.swift
//  lab1
//
//  Created by Vlad Nechiporenko on 12/3/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

class Country {
    var ready = false
    var name: String?
    var cities = [City]()
    private var xl: Int?
    private var yl: Int?
    private var xh: Int?
    private var yh: Int?
    var days = 0
    
    init(_ name: String,_ xl: Int,_ yl: Int,_ xh: Int,_ yh: Int){
        self.name = name
        self.xl = xl
        self.yl = yl
        self.xh = xh
        self.yh = yh
        getCities()
    }
    
    private func getCities(){
        for x in xl!...xh!{
            for y in yl!...yh!{
                cities.append(City(x, y))
            }
        }
    }
    
    func updateReadyState(){
        var count = 0
        for city in cities {
            if city.ready == true {
                count += 1
            }
        }
        if count == cities.count {
            ready = true
        }
    }
    
}
