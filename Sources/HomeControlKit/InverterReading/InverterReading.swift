//
//  InverterReading.swift
//  HomeControlKit
//
//  Created by Christoph Pageler on 30.04.24.
//

import Foundation

public struct InverterReading: Codable {
    public var readingAt: Date

    public var solarToBattery: Double
    public var solarToLoad: Double
    public var solarToGrid: Double

    public var batteryToLoad: Double
    public var batteryToGrid: Double

    public var gridToBattery: Double
    public var gridToLoad: Double

    public var batteryLevel: Double
    public var batteryHealth: Double
    public var batteryTemperature: Double

    /// PV Ertrag (Heute)
    public var dailyPVGeneration: Double

    /// Netzbezug (Heute)
    public var dailyImportEnergy: Double

    /// Netzeinspeisung (Heute)
    public var dailyExportEnergy: Double

    /// Direkt verbrauchte Energie (Heute)
    public var dailyDirectEnergyConsumption: Double

    /// Aus Batterie verbrauchte Energie (Heute)
    public var dailyBatteryDischargeEnergy: Double

    public init(
        readingAt: Date,
        solarToBattery: Double,
        solarToLoad: Double,
        solarToGrid: Double,
        batteryToLoad: Double,
        batteryToGrid: Double,
        gridToBattery: Double,
        gridToLoad: Double,
        batteryLevel: Double,
        batteryHealth: Double,
        batteryTemperature: Double,
        dailyPVGeneration: Double,
        dailyImportEnergy: Double,
        dailyExportEnergy: Double,
        dailyDirectEnergyConsumption: Double,
        dailyBatteryDischargeEnergy: Double
    ) {
        self.readingAt = readingAt
        self.solarToBattery = solarToBattery
        self.solarToLoad = solarToLoad
        self.solarToGrid = solarToGrid
        self.batteryToLoad = batteryToLoad
        self.batteryToGrid = batteryToGrid
        self.gridToBattery = gridToBattery
        self.gridToLoad = gridToLoad
        self.batteryLevel = batteryLevel
        self.batteryHealth = batteryHealth
        self.batteryTemperature = batteryTemperature
        self.dailyPVGeneration = dailyPVGeneration
        self.dailyImportEnergy = dailyImportEnergy
        self.dailyExportEnergy = dailyExportEnergy
        self.dailyDirectEnergyConsumption = dailyDirectEnergyConsumption
        self.dailyBatteryDischargeEnergy = dailyBatteryDischargeEnergy
    }
}

public extension InverterReading {
    var fromSolar: Double { solarToBattery + solarToLoad + solarToGrid }
    var fromGrid: Double { gridToBattery + gridToLoad }
    var fromBattery: Double { batteryToLoad + batteryToGrid }
    var toLoad: Double { solarToLoad + batteryToLoad + gridToLoad }
    var toGrid: Double { solarToGrid + batteryToGrid }
    var toBattery: Double { solarToBattery + gridToBattery }
}

public extension InverterReading {
    var isCharging: Bool { toBattery > 0 }
    var isDischarging: Bool { fromBattery > 0 }
}

public extension InverterReading {
    enum BatteryState {
        case idle
        case isCharging
        case isDischarging
    }

    var batteryState: BatteryState {
        if isCharging {
            return .isCharging
        } else if isDischarging {
            return .isDischarging
        } else {
            return .idle
        }
    }
}

public extension InverterReading {
    /// Verbrauchte Energie (Heute)
    var dailyTotalConsumption: Double { dailyDirectEnergyConsumption + dailyBatteryDischargeEnergy + dailyImportEnergy }
}

public extension InverterReading {
    private static var formatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()

    private func formatted(_ value: Double, numberStyle: NumberFormatter.Style = .decimal, suffix: String = "") -> String {
        Self.formatter.numberStyle = numberStyle
        Self.formatter.negativeSuffix = suffix
        Self.formatter.positiveSuffix = suffix
        return Self.formatter.string(from: NSNumber(value: value)) ?? ""
    }

    func formatted(_ keyPath: KeyPath<InverterReading, Double>) -> String {
        let value = self[keyPath: keyPath]
        switch keyPath {
        case 
            \.batteryHealth,
            \.batteryLevel:
            return formatted(value / 100, numberStyle: .percent, suffix: " %")
        case 
            \.batteryTemperature:
            return formatted(value, suffix: " °C")
        case 
            \.dailyPVGeneration,
            \.dailyImportEnergy,
            \.dailyExportEnergy,
            \.dailyDirectEnergyConsumption,
            \.dailyBatteryDischargeEnergy:
            return formatted(value, suffix: " kWh")
        case 
            \.solarToBattery,
            \.solarToLoad,
            \.solarToGrid,
            \.batteryToLoad,
            \.batteryToGrid,
            \.gridToBattery,
            \.gridToLoad,
            \.fromSolar,
            \.fromGrid,
            \.fromBattery,
            \.toLoad,
            \.toGrid,
            \.toBattery:
            return formatted(value, suffix: " W")
        default:
            return formatted(value)
        }
    }
}
