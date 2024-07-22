//
//  ObjectiveView.swift
//  OCKSample
//
//  Created by Rodrigo Aguilar Barrios on 7/21/24.
//  Copyright © 2024 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI
import CareKit
import CareKitStore
import os.log
import UIKit


struct ObjectiveView: View {
    @CareStoreFetchRequest(query: query()) private var events
    @State var taskOutcomes = [String: OCKOutcomeValue]()
   
    
    var body: some View {
        VStack{
            ForEach(Array(taskOutcomes.keys), id: \.self) { key in
                statView(title: key, outcome: taskOutcomes[key]?.numberValue ?? 2)
            }
            
        }
        .onAppear{
            print("DOES ITS TASK")
            var tasks = [OCKOutcomeValue]()
            for event in events{
                guard let outcomeTest = event.result.outcomeValues else { return}
                for outcome in event.result.outcomeValues! {
                    
                    taskOutcomes[event.result.title] = outcome
                }
                
                
            }
           
        }
    }
        
    
    static func query() -> OCKEventQuery {
        var query = OCKEventQuery(for: Date())
        query.taskIDs = [TaskID.steps, TaskID.heartRate, TaskID.bloodPressure]
        return query
    }
    
    
    
}


struct statView: View {
    var title: String
    var outcome: NSNumber
    
    var body: some View {
        Capsule()
                .fill(Color.blue)
                .overlay(
                    Text("\(title) : \(outcome)")
                )
                
    }
}

#Preview {
    ObjectiveView()
}
