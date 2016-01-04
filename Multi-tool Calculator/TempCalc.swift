//
//  TempCalc.swift
//  Sample Slidebar
//
//  Created by Avram-Chaim Levy on 2015-12-27.
//  Copyright © 2015 Avram-Chaim Levy. All rights reserved.
//

import Foundation


class TempCalc{
    
    var celsius:Double = 0
    var fahrenheit: Double = 0
    var calculatedCelsius: Double = 0
    var calculatedFahrenheit: Double = 0
    
    func calcCelsius() {
        calculatedCelsius = (fahrenheit - 32)/1.8
        print("fahrenheit \(fahrenheit)")
        print("calculatedCelsius \(calculatedCelsius)")
    }
    
    func calcFahrenheit() {
        calculatedFahrenheit = (celsius*1.8) + 32
    }
    
}