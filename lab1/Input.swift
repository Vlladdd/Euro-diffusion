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
    var errors = [String]()
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
            errors.append("First symbol is not digit!")
        }
        
        for x in newStringArray! {
            if errors.count == 0 && !endOfFIle{
                if countryCount == 0{
                    if Int(x) != nil && errors.count == 0 {
                        countryCount = Int(x)!
                        if (countryCount < 1 || countryCount > 20) && countryCount != 0{
                            errors.append("Number of countries should be more then 0 and less then 20!")
                        }
                        if countryCount == 0 {
                            endOfFIle = true
                        }
                    }
                    else{
                        errors.append("Wrong data!")
                    }
                }
                else if errors.count == 0{
                    let newStringArray1 = x.components(separatedBy:" ")
                    if newStringArray1.count != 5 {
                        errors.append("Too many or too less data in string describing country!")
                    }
                    else {
                        let condition = Int(newStringArray1[1]) != nil && Int(newStringArray1[2]) != nil && Int(newStringArray1[3]) != nil && Int(newStringArray1[4]) != nil
                        let condition1 = newStringArray1[0].rangeOfCharacter(from: decimalCharacters) == nil && newStringArray1[0].count > 0 && newStringArray1[0].count < 26
                        if condition {
                            if  condition1 && checkCondition(newStringArray1,1,3) && checkCondition(newStringArray1,2,4){
                                let country = Country(newStringArray1[0], Int(newStringArray1[1])!, Int(newStringArray1[2])!, Int(newStringArray1[3])!, Int(newStringArray1[4])!)
                                countries.append(country)
                                countryCount -= 1
                            }
                            else {
                                errors.append("Wrong data of country!")
                            }
                        }
                        else {
                            errors.append("Wrong data of country!")
                        }
                    }
                }
                if countryCount == 0 && !endOfFIle && errors.count == 0{
                    for x in 0...countries.count-1{
                        for y in 0...countries.count-1{
                            if x != y && countries[x].name == countries[y].name
                            {
                                if errors.count == 0{
                                    errors.append("Countries with same name!")
                                }
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
    
    private func checkCondition(_ newStringArray1: [String], _ x: Int, _ y: Int) -> Bool {
        if Int(newStringArray1[x])! >= 1 && Int(newStringArray1[x])! <= 10 && Int(newStringArray1[y])! >= 1 && Int(newStringArray1[y])! <= 10 && Int(newStringArray1[y])! >= Int(newStringArray1[x])! {
            return true
        }
        return false
    }
    
    private func outputErrors() {
        if errors.count > 0 {
            for error in errors{
                print(error)
            }
        }
    }

}


