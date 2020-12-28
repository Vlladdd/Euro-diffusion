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
    private let initialMotifsCount = 1000000
    private let portionDivisor = 1000
    var errors = [String]()

    
    init?(_ countries: [Country]){
        self.countries = countries
        for country in countries {
            for city in country.cities{
                if !error{
                    city.motif_id = motif_id
                    city.motifs[motif_id] = initialMotifsCount
                    if checkIfEmpty(city.x!, city.y!){
                        cities.append(city)
                    }
                    else {
                        return nil
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
                    city.updateReadyState(countriesCount)
                }
                if country.ready == false {
                    country.updateReadyState()
                }
                if country.ready == false {
                    country.days += 1
                }
            }
            ready = updateReadyState()
            coinsTransfer()
        }
    }
    
    private func checkCountries() -> Bool{
        for country in countries {
            for city in country.cities{
                for neighbour in city.neighbors {
                    if city.motifs != neighbour.motifs {
                        return true
                    }
                }
            }
        }
        return false
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
                    if city.motifs[key]! >= portionDivisor {
                        value = Int(city.motifs[key]!/portionDivisor)
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
    
    private func updateReadyState() -> Bool{
        for city in cities {
            if city.ready == false {
                return false
            }
        }
        return true
    }
}
