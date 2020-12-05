//
//  Grid.swift
//  lab1
//
//  Created by Vlad Nechiporenko on 12/3/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

class Grid{
    private var ready = false
    private var cities = [City]()
    private var countries = [Country]()
    private var id = 0
    private var motif_id = 0
    private var countriesCount = 0
    private var error = false
    var errors = [String]()

    
    init(_ countries: [Country]){
        self.countries = countries
        for country in countries {
            for city in country.cities{
                if !error{
                    city.motif_id = motif_id
                    city.motifs[motif_id] = 1000000
                    if checkIfEmpty(city.x!, city.y!){
                        cities.append(city)
                    }
                    else {
                        error = true
                        errors.append("Cities from different countries have same coordinates!")
                    }
                }
            }
            motif_id += 1
        }
        for city in cities {
            city.id = id
            id += 1
        }
        for city in cities {
            city.motifsAfterDay = city.motifs
        }
        calculateNeighbours()
        countriesCount = countries.count
        if checkCountries() && !error{
            execute()
        }
        else if countries.count > 1{
            errors.append("Not all countries have neighbours!")
        }
    }
    
    private func execute(){
        while(ready == false){
            for country in countries {
                for city in country.cities{
                    city.isReady(countriesCount)
                }
                country.isReady()
                if country.ready == false {
                    country.days += 1
                }
            }
            isReady()
            coinsTransfer()
        }
    }
    
    private func checkCountries() -> Bool{
        var possible = false
        for country in countries {
            possible = false
            for city in country.cities{
                for neighbour in city.neighbors {
                    if city.motifs != neighbour.motifs {
                        possible = true
                    }
                }
            }
            if !possible {
                return possible
            }
        }
        return possible
    }
    
    private func checkIfEmpty(_ x: Int, _ y: Int) -> Bool{
        for city in cities {
            if city.x! == x && city.y! == y {
                return false
            }
        }
        return true
    }
    private func calculateNeighbours(){
        for city in cities {
            for isNeighbour in cities {
                if (city.x! - 1 == isNeighbour.x! || city.x! + 1 == isNeighbour.x!) && city.y! == isNeighbour.y!{
                    city.neighbors.append(isNeighbour)
                }
                if (city.y! - 1 == isNeighbour.y! || city.y! + 1 == isNeighbour.y!) && city.x! == isNeighbour.x!{
                    city.neighbors.append(isNeighbour)
                }
            }
        }
    }
    
    private func coinsTransfer(){
        for city in cities {
            for neigbour in city.neighbors {
                for (key,_) in city.motifs {
                    var value = 0
                    if city.motifs[key]! >= 1000 {
                        value = Int(city.motifs[key]!/1000)
                    }
                    if value > 0 {
                        for city2 in cities{
                            if city2.id == neigbour.id {
                                city2.motifsAfterDay[key] = (city2.motifsAfterDay[key] ?? 0) + value
                            }
                        }
                        city.motifsAfterDay[key] = city.motifsAfterDay[key]! - value
                    }
                }
            }
        }
        for city in cities {
            city.motifs = city.motifsAfterDay
        }
    }
    
    private func isReady(){
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
