//
//  TaxCalc.swift
//  Sample Slidebar
//
//  Created by Avram-Chaim Levy on 2015-12-22.
//  Copyright © 2015 Avram-Chaim Levy. All rights reserved.
//

import Foundation

class TaxCalc
{
    var taxAmount: Float = 0
    var taxPartialAmount: Float = 0
    var amountBeforeTax: Float = 0
    var taxPercentage: Float = 0
    var totalAmount: Float = 0
    
    init(amountBeforeTax: Float, taxPercentage: Float)
    {
        self.amountBeforeTax = amountBeforeTax
        self.taxPercentage = taxPercentage
    }
    func calculateTax(){
        taxAmount = amountBeforeTax * taxPercentage
        totalAmount = amountBeforeTax + taxAmount
    }
    func calculateTaxPartial (taxPartial: Float) -> Float{
        taxPartialAmount = amountBeforeTax * taxPartial
       return taxPartialAmount
        
    }
}