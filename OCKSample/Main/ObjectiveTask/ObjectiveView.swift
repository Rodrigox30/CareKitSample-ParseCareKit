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
    @State var taskOutcomes = [String: (NSNumber, String)]()
   
    
    var body: some View {
        ScrollView{
            ForEach(Array(taskOutcomes.keys), id: \.self) { key in
                StatView(title: key, outcome: taskOutcomes[key]?.0 ?? 0, units: taskOutcomes[key]?.1 ?? "None")
                    .padding()
            }
            
        }
        .onAppear{
            for event in events{
                
                guard let outcome = event.result.outcomeValues?.first else { continue}
               
                
                taskOutcomes[event.result.title] = (outcome.numberValue!, outcome.units!)
                
                
                
                    
            }
           
        }
    }
        
    
    static func query() -> OCKEventQuery {
        print("BEFORE?")
        var query = OCKEventQuery(for: Date())
        query.taskIDs = TaskID.objective
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
