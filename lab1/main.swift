//
//  main.swift
//  lab1
//
//  Created by Vlad Nechiporenko on 12/3/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation


var input = Input("file:///Users/vladnechiporenko/Developer/lab1/lab1/test")
if input.errors.count == 0{
    if input.data.count > 0{
        for x in 0...input.data.count-1{
            let grid = Grid(input.data[x]!)
            _ = Output(input.data[x]!,x+1,grid.errors)
        }
    }
}



