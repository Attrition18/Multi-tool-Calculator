//
//  Region.swift
//  Sample Slidebar
//
//  Created by Avram-Chaim Levy on 2015-12-22.
//  Copyright © 2015 Avram-Chaim Levy. All rights reserved.
//

import Foundation


class region {
    //MARK: - Var
    //HST GST PST RST QST
    var provinceTax: [[Float]] = [[0,0.05,0.07,0,0], //BC
                            [0,0.05,0,0,0],  //Alberta
                            [0,0.05,0.05,0,0], //Saskatchewan
                            [0,0.05,0,0.08,0], //Manitoba
                            [0.13,0,0,0,0], //Ontario
                            [0,0.05,0,0,0.09975], //Qubec
                            [0.13,0,0,0,0],//New Brunswick
                            [0.15,0,0,0,0], //Nova Scotia
                            [0.13,0,0,0,0],//Newfoundland and labrador
                            [0.14,0,0,0,0],//Prince Edward Island
                            [0,0.05,0,0,0],//Yukon
                            [0,0.05,0,0,0],//North Western Territories
                            [0,0.05,0,0,0]]//Nunavut
    var province:Int = 0
    var x: Int = 0
    var totalTax: Float = 0
    var provinceName: String?
    
    
    //MARK: - Properties
    func setProvince(province:Int){
    self.province = province
    }
    
    func getHSTTax() -> Float{
        return provinceTax[province][0]
    }
    func getGSTTax() -> Float{
        return provinceTax[province][1]
    }
    func getPSTTax() -> Float{
        return provinceTax[province][2]
    }
    func getRSTTax() -> Float{
        return provinceTax[province][3]
    }
    func getQSTTax() -> Float{
        return provinceTax[province][4]
    }
    func calcTotalTax(){
        totalTax = getHSTTax() + getGSTTax() + getPSTTax() + getRSTTax() + getQSTTax()
    }
    func getProvince() ->String{
        switch province {
        case 0:
            return "British Columbia"
        case 1:
            return "Alberta"
        case 2:
            return "Saskatchewan"
        case 3:
            return "Manitoba"
        case 4:
            return "Ontario"
        case 5:
            return "Qubec"
        case 6:
            return "New Brunswick"
        case 7:
            return "Nova Scotia"
        case 8:
            return "Newfoundland and Labrador"
        case 9:
            return "Prince Edward Island"
        case 10:
            return "Yukon"
        case 11:
            return "North Western Territories"
        case 12:
            return "Nunavut"
        default:
            return "Ontario"
        }
        
    }
}