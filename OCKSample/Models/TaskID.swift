//
//  TaskID.swift
//  OCKSample
//
//  Created by Corey Baker on 4/14/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

enum TaskID {
    static let doxylamine = "doxylamine"
    static let nausea = "nausea"
    static let stretch = "stretch"
    static let kegels = "kegels"
    static let steps = "steps"
    static let heartRate = "heartRate"
    static let bloodPressure = "bloodPressure"
    static let bodyFatPercentage = "bodyFatPercentage"
    static let bodyMassIndex = "bodyMassIndex"
    static let activeEnergyBurned = "activeEnergyBurned"
    static let heartRateVariabilitySDNN = "heartRateVariabilitySDNN"
    static let respiratoryRate = "respiratoryRate"
    static let environmentalAudioExposure = "environmentalAudioExposure"
    static let timeInDaylight = "timeInDaylight"
    

    static var ordered: [String] {
        [Self.steps, Self.doxylamine, Self.kegels, Self.stretch, Self.nausea, Self.heartRate]
    }
    static var objective : [String] {
        [Self.steps, Self.heartRate, Self.bloodPressure, Self.bodyFatPercentage, Self.bodyMassIndex, Self.activeEnergyBurned, Self.heartRateVariabilitySDNN, Self.respiratoryRate, Self.environmentalAudioExposure, Self.timeInDaylight]
    }
}
