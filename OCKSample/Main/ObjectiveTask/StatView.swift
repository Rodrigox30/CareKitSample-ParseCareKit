//
//  StatView.swift
//  OCKSample
//
//  Created by Rodrigo Aguilar Barrios on 7/22/24.
//  Copyright © 2024 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI

struct StatView: View {
    var title: String
    var outcome: NSNumber 
    var units: String
    var body: some View {

        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: 70, height: 30))
                .fill(Color(red: 1.0, green: 0.8, blue: 0.0))
                .frame(width: 300, height: 200)
                
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.5976, green: 0.0, blue: 0.0))
                        .frame(width: 200, height: 130)
                        
                    VStack {
                        Text(title)
                            .foregroundStyle(.white)
                            .font(.custom("SF Pro", size: 27))
                         
                        Text("\(outcome)")
                            .foregroundStyle(.white)
                            .font(.custom("SF Pro", size: 45, relativeTo: .title2))
                        Text(units)
                            .foregroundStyle(.white)
                            .font(.custom("SF Pro", size: 45, relativeTo: .title2))
                            
                    }
                }
                HStack {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 10, height: 10)
                    Rectangle()
                        .fill(.white)
                        .frame(width: 10, height: 10)
                    Rectangle()
                        .fill(.white)
                        .frame(width: 10, height: 10)

                }
            }
            
        }
    }
}

#Preview {
    StatView(title:"Test", outcome: NSNumber(97), units: "ME" )
}
