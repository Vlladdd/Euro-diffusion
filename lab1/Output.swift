//
//  Output.swift
//  lab1
//
//  Created by Vlad Nechiporenko on 12/5/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

class Output{
    private var myCase = 1
    private var countries = [Country]()
    private var errors = [String]()
    
    init(_ countries: [Country], _ myCase: Int,_ errors: [String]){
        self.countries = countries
        self.myCase = myCase
        self.errors = errors
        output()
    }
    
    private func output() {
        print("Case Number \(myCase)")
        countries.sort { ($0.days, $0.name!) < ($1.days, $1.name!) }
        if errors.count == 0 {
            for country in countries {
                print("\(country.name!) \(country.days)")
            }
        }
        else{
            for error in errors {
                print(error)
            }
        }
    }
}
