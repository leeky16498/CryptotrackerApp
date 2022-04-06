//
//  Double.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 06/04/2022.
//

import Foundation

extension Double {
    
    /// converts a double into currency with 2 decimal places
    private var currencyFormatter2 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// converts a double into currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormatter6 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // default value
//        formatter.currencyCode = "usd" // change currency
//        formatter.currencySymbol = "$" // cahnge currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    //converts a Double into String respresentation
    //앞에 두개 잘라버린다.
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}
