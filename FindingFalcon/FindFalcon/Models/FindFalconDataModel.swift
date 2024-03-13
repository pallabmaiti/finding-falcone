//
//  FindFalconDataModel.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 13/03/24.
//

import Foundation

enum DestinationType {
    case one
    case two
    case three
    case four
}

@Observable
class Destination: Identifiable {
    var planetList: [Planet] = []
    var vehicleList: [Vehicle] = []
    var selectedVehicle: Vehicle?
    var selectedPlanet: Planet?
    let id = UUID()
    
    var timeTaken: Int {
        guard let sP = selectedPlanet, let sV = selectedVehicle else {
            return 0
        }
        return sP.distance / sV.speed
    }
    
    let name: String

    init(name: String) {
        self.name = name
    }
    
    func reset() {
        resetPlanet()
        resetVehicle()
    }
    
    func resetPlanet() {
        planetList = []
        selectedPlanet = nil
    }
    
    func resetVehicle() {
        vehicleList = []
        selectedVehicle = nil
    }
}

@Observable
class FindFalconDataModel {
    var destinations = [
        Destination(name: "Destination 1"),
        Destination(name: "Destination 2"),
        Destination(name: "Destination 3"),
        Destination(name: "Destination 4")
    ]
    
    var totalTimeTaken: Int {
        return destinations.map{ $0.timeTaken }.reduce(0) { $0 + $1 }
    }
    
    var shouldButtonDisabled: Bool {
        var count = 0
        while count < destinations.count {
            if (destinations[count].selectedVehicle == nil) {
                return true
            }
            count += 1
        }
        return false
    }
    
    func reset() {
        destinations.forEach{ $0.reset() }
    }
    
    func updateDestinationVehicleList(destination: Destination, list: [Vehicle]) {
        if let index = destinations.firstIndex(where: { $0.id == destination.id }), index < (destinations.count - 1) {
            for i in (index + 1)..<destinations.count {
                destinations[i].resetVehicle()
            }
            destinations[index + 1].vehicleList = list.map{ Vehicle(name: $0.name, totalNo: $0.totalNo, maxDistance: $0.maxDistance, speed: $0.speed) }
        }
    }
    
    func updateDestinationPlanetList(destination: Destination, list: [Planet]) {
        if let index = destinations.firstIndex(where: { $0.id == destination.id }), index < (destinations.count - 1) {
            for i in (index + 1)..<destinations.count {
                destinations[i].resetPlanet()
            }
            var pList = list.map{ Planet(name: $0.name, distance: $0.distance) }
            pList.removeAll(where: { $0.name == destination.selectedPlanet?.name })
            destinations[index + 1].planetList = pList
        }
    }
}
