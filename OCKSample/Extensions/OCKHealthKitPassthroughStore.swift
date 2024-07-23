//
//  OCKHealthKitPassthroughStore.swift
//  OCKSample
//
//  Created by Corey Baker on 1/5/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
import HealthKit
import os.log

extension OCKHealthKitPassthroughStore {

    func addTasksIfNotPresent(_ tasks: [OCKHealthKitTask]) async throws {
        
        let tasksToAdd = tasks
        
        
        let taskIdsToAdd = tasksToAdd.compactMap { $0.id }

        // Prepare query to see if tasks are already added
        var query = OCKTaskQuery(for: Date())
        query.ids = taskIdsToAdd

        let foundTasks = try await fetchTasks(query: query)
        var tasksNotInStore = [OCKHealthKitTask]()

        // Check results to see if there's a missing task
        tasksToAdd.forEach { potentialTask in
            
            if foundTasks.first(where: { $0.id == potentialTask.id }) == nil {
                
                tasksNotInStore.append(potentialTask)
            }
        }

        // Only add if there's a new task
        if tasksNotInStore.count > 0 {
            do {
                _ = try await addTasks(tasksNotInStore)
                Logger.ockHealthKitPassthroughStore.info("Added tasks into HealthKitPassthroughStore!")
            } catch {
                Logger.ockHealthKitPassthroughStore.error("Error adding HealthKitTasks: \(error)")
            }
        }
    }

    func populateSampleData() async throws {

        let stepschedule = OCKSchedule.dailyAtTime(
            hour: 0, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(24), targetValues: [OCKOutcomeValue(2000.0, units: "Steps")])

        var steps = OCKHealthKitTask(
            id: TaskID.steps,
            title: "Steps",
            carePlanUUID: nil,
            schedule: stepschedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .stepCount,
                quantityType: .cumulative,
                unit: .count()))
        steps.asset = "figure.walk"
        
        
        let schedule = OCKSchedule.dailyAtTime(
            hour: 0, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(24))
        
        var heartRate = OCKHealthKitTask(
            id: TaskID.heartRate,
            title: "Heart Rate",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .heartRate,
                quantityType: .discrete,
                unit:  HKUnit.count().unitDivided(by: HKUnit.minute())))
        heartRate.asset = "figure.walk"
        
        var bloodPressureSchedule = OCKSchedule.dailyAtTime(
            hour: 0, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(24))
        var bloodPressure = OCKHealthKitTask(
            id: TaskID.bloodPressure,
            title: "Blood Pressure",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .bloodPressureSystolic,
                quantityType: .discrete,
                unit:  .millimeterOfMercury()))
        heartRate.asset = "figure.walk"

       
        var bodyFatPercent = OCKHealthKitTask(
            id: TaskID.bodyFatPercentage,
            title: "Body Fat Percent",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .bodyFatPercentage,
                quantityType: .discrete,
                unit:  .percent()))
        
        var bodyMassIndex = OCKHealthKitTask(
            id: TaskID.bodyMassIndex,
            title: "Body Mass Index",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .bodyMassIndex,
                quantityType: .discrete,
                unit:  .count()))
        
        
        
        heartRate.asset = "figure.walk"
        
        let activeEnergyBurnedSchedule = OCKSchedule.dailyAtTime(
            hour: 0, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(24))
        
        var activeEnergyBurned = OCKHealthKitTask(
            id: TaskID.activeEnergyBurned,
            title: "Active Energy Burned",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .activeEnergyBurned,
                quantityType: .discrete,
                unit:  .kilocalorie()))
        activeEnergyBurned.asset = "figure.walk"
        
        
        let heartRateVariabilitySDNNSchedule = OCKSchedule.dailyAtTime(
            hour: 0, minutes: 0, start: Date(), end: nil, text: nil)
        var heartRateVariabilitySDNN  = OCKHealthKitTask(
            id: TaskID.heartRateVariabilitySDNN,
            title: "Heart Rate Variability",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .heartRateVariabilitySDNN,
                quantityType: .discrete,
                unit:  HKUnit.secondUnit(with: .milli) ))
        
        let respiratoryRateSchedule = OCKSchedule.dailyAtTime(
            hour: 0, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(12))
        
        var respiratoryRate = OCKHealthKitTask(
            id: TaskID.respiratoryRate,
            title: "Respiratory Rate",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .respiratoryRate,
                quantityType: .discrete,
                unit:  .count().unitDivided(by: .minute() )))
        var environmentalAudioExposure = OCKHealthKitTask(
            id: TaskID.environmentalAudioExposure,
            title: "Environmental Audio Exposure",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .environmentalAudioExposure,
                quantityType: .discrete,
                unit:  .decibelHearingLevel() ))
        
        if #available(iOS 17.0, *) {
            var timeInDaylight = OCKHealthKitTask(
                id: TaskID.timeInDaylight,
                title: "Time In Daylight",
                carePlanUUID: nil,
                schedule: schedule,
                healthKitLinkage: OCKHealthKitLinkage(
                    quantityIdentifier: .timeInDaylight,
                    quantityType: .discrete,
                    unit:  .second() ))
            try await addTasksIfNotPresent([timeInDaylight])
        }
        
        try await addTasksIfNotPresent([steps,heartRate, bloodPressure, bodyFatPercent, bodyMassIndex,activeEnergyBurned, heartRateVariabilitySDNN, respiratoryRate,
                                        environmentalAudioExposure])
    }
}
