//
//  InverterReading.swift
//  HomeControlKit
//
//  Created by Christoph Pageler on 30.04.24.
//

import Foundation

public struct InverterReading: Codable, Equatable, Hashable {
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
        return numberFormatter
    }()

    private func formatted(
        _ value: Double,
        numberStyle: NumberFormatter.Style = .decimal,
        suffix: String = "",
        maximumFractionDigits: Int = 1
    ) -> String {
        Self.formatter.numberStyle = numberStyle
        Self.formatter.negativeSuffix = suffix
        Self.formatter.positiveSuffix = suffix
        Self.formatter.maximumFractionDigits = maximumFractionDigits
        return Self.formatter.string(from: NSNumber(value: value)) ?? ""
    }

    func formatted(
        _ keyPath: KeyPath<InverterReading, Double>,
        options: InverterReadingFormattingOptions = []
    ) -> String {
        let value = self[keyPath: keyPath]
        switch keyPath {
        case
            \.batteryHealth,
            \.batteryLevel:
            if options.contains(.short) {
                return formatted(value, numberStyle: .percent, suffix: " %", maximumFractionDigits: 0)
            } else {
                return formatted(value, numberStyle: .percent, suffix: " %")
            }
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
            if options.contains(.short) {
                return formatted(value / 1000, suffix: " kW")
            } else {
                return formatted(value, suffix: " W")
            }
        default:
            return formatted(value)
        }
    }
}

public struct InverterReadingFormattingOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let short = InverterReadingFormattingOptions(rawValue: 1 << 0)
}

public extension InverterReading {
    static func sample(
        readingAt: Date = Date(),
        solarToBattery: Double = 0.0,
        solarToLoad: Double = 0.0,
        solarToGrid: Double = 0.0,
        batteryToLoad: Double = 0.0,
        batteryToGrid: Double = 0.0,
        gridToBattery: Double = 0.0,
        gridToLoad: Double = 0.0,
        batteryLevel: Double = 0.0,
        batteryHealth: Double = 0.0,
        batteryTemperature: Double = 0.0,
        dailyPVGeneration: Double = 0.0,
        dailyImportEnergy: Double = 0.0,
        dailyExportEnergy: Double = 0.0,
        dailyDirectEnergyConsumption: Double = 0.0,
        dailyBatteryDischargeEnergy: Double = 0.0
    ) -> InverterReading {
        .init(
            readingAt: readingAt,
            solarToBattery: solarToBattery,
            solarToLoad: solarToLoad,
            solarToGrid: solarToGrid,
            batteryToLoad: batteryToLoad,
            batteryToGrid: batteryToGrid,
            gridToBattery: gridToBattery,
            gridToLoad: gridToLoad,
            batteryLevel: batteryLevel,
            batteryHealth: batteryHealth,
            batteryTemperature: batteryTemperature,
            dailyPVGeneration: dailyPVGeneration,
            dailyImportEnergy: dailyImportEnergy,
            dailyExportEnergy: dailyExportEnergy,
            dailyDirectEnergyConsumption: dailyDirectEnergyConsumption,
            dailyBatteryDischargeEnergy: dailyBatteryDischargeEnergy
        )
    }
}
