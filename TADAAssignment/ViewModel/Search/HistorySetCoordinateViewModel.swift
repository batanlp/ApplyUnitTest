//
//  HistorySetCoordinateViewModel.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 14/10/2021.
//

import UIKit

class HistorySetCoordinateViewModel: NSObject {
    
    var listCoordinate: [CoordinateTADA] = [CoordinateTADA]()
    
    override init() {
        self.listCoordinate = CDCoordinateManager.shared.getCoordinatesList()!
    }
    
    func getTotalCoordinate() -> Int {
        return listCoordinate.count
    }
    
    func getCoordinate(atIndex: Int) -> CoordinateTADA{
        return listCoordinate[atIndex]
    }
}
