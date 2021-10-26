//
//  Variable+Extension.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 12/10/2021.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
