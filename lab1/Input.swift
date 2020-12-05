//
//  Input.swift
//  lab1
//
//  Created by Vlad Nechiporenko on 12/5/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

class Input{
    private var text: String?
    private let newStringArray: [String]?
    private let decimalCharacters = CharacterSet.decimalDigits
    var error = false
    private var errors = [String]()
    private var countryCount = 0
    private var countries = [Country]()
    private var endOfFIle = false
    private let fileUrl: URL?
    var data = [Int: [Country]]()
    private var dataId = 0

    
    init(_ fileName: String) {
        fileUrl = URL(string:fileName)
        do {
            text = try String(contentsOf: fileUrl!, encoding: .utf8)
        }
        catch {}
        newStringArray = text?.components(separatedBy:"\n")
        checkForErrors()
        outputErrors()
    }

    private func checkForErrors(){
        if (Int(newStringArray![0])) == nil {
            error = true
            errors.append("First symbol is not digit!")
        }
        
        for x in newStringArray! {
            if !error && !endOfFIle{
                if countryCount == 0{
                    if Int(x) != nil && !error {
                        countryCount = Int(x)!
                        if (countryCount < 1 || countryCount > 20) && countryCount != 0{
                            error = true
                            errors.append("Number of countries should be more then 0 and less then 20!")
                        }
                        if countryCount == 0 {
                            endOfFIle = true
                        }
                    }
                    else{
                        error = true
                        errors.append("Wrong data!")
                    }
                }
                else if !error{
                    let newStringArray1 = x.components(separatedBy:" ")
                    if newStringArray1.count != 5 {
                        error = true
                        errors.append("Too many or too less data in string describing country!")
                    }
                    else {
                        if newStringArray1[0].rangeOfCharacter(from: decimalCharacters) == nil && newStringArray1[0].count > 0 && newStringArray1[0].count < 26 && Int(newStringArray1[1]) != nil && Int(newStringArray1[1])! >= 1 && Int(newStringArray1[1])! <= 10 && Int(newStringArray1[3]) != nil && Int(newStringArray1[3])! >= 1 && Int(newStringArray1[3])! <= 10 && Int(newStringArray1[3])! >= Int(newStringArray1[1])! && Int(newStringArray1[2]) != nil && Int(newStringArray1[2])! >= 1 && Int(newStringArray1[2])! <= 10 && Int(newStringArray1[4]) != nil && Int(newStringArray1[4])! >= 1 && Int(newStringArray1[4])! <= 10 && Int(newStringArray1[4])! >= Int(newStringArray1[2])!{
                            let country = Country(newStringArray1[0], Int(newStringArray1[1])!, Int(newStringArray1[2])!, Int(newStringArray1[3])!, Int(newStringArray1[4])!)
                            countries.append(country)
                            countryCount -= 1
                        }
                        else {
                            error = true
                            errors.append("Wrong data of country!")
                        }
                    }
                }
                if countryCount == 0 && !endOfFIle && !error{
                    for x in 0...countries.count-1{
                        for y in 0...countries.count-1{
                            if x != y && countries[x].name == countries[y].name
                            {
                                if !error{
                                    errors.append("Countries with same name!")
                                }
                                error = true
                            }
                        }
                    }
                    data[dataId] = countries
                    countries = []
                    dataId += 1
                }
            }
        }
    }
    
    private func outputErrors() {
        if error {
            for x in errors {
                print(x)
            }
        }
    }

}
