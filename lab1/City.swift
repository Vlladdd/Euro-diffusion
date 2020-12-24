//
//  City.swift
//  lab1
//
//  Created by Vlad Nechiporenko on 12/3/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

class City {
    var ready = false
    var id = 0
    var x: Int?
    var y: Int?
    var neighbors = [City]()
    var motif_id = 0
    var motifs = [Int:Int]()
    var motifsAfterDay = [Int:Int]()
    
    init(_ x: Int,_ y: Int){
        self.x = x
        self.y = y
    }
    
    func updateReadyState(_ countriesCount: Int){
        if motifs.count == countriesCount {
            ready = true
        }
    }
    
}
