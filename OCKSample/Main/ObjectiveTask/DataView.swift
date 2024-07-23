//
//  StatView2.swift
//  OCKSample
//
//  Created by Emily Mojica on 7/22/24.
//  Copyright © 2024 Network Reconnaissance Lab. All rights reserved.
//
// Designing Results Page

import SwiftUI

struct DataView: View {
    var title: String
    var outcome: NSNumber
    var body: some View {

        ZStack{
            //Gray Background
            Rectangle()
                .fill(Color(.systemGray5))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    
            //White Box
            Rectangle()
                .fill(.white)
                .frame(width: 350, height: 150)
                .cornerRadius(20.0)
            
            //Text & Padding
            HStack{
                VStack(alignment:.leading){
                    Text(title)
                        .foregroundColor(Color(red:0.5976, green: 0.0, blue:0.0))
                        .font(.custom("SF Pro Display", size:30))
                        .multilineTextAlignment(.leading)

                    HStack(alignment:.bottom, spacing: 0.2){
                    Text("\(outcome)")
                        .foregroundColor(.black)
                        .font(.custom("SF Pro Display", size:50))
                        .multilineTextAlignment(.leading)
                    
                    Text("?")
                        .foregroundColor(.gray)
                        .font(.custom("SF Pro Display", size:20))
                        .multilineTextAlignment(.leading)
                        .padding(7.5)
                }
                }
                //Image & Padding
                .padding(.trailing,60)
                HStack{
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width:50, height:50)
                        .padding(.leading, 20)
                        .padding(.top, 25)
                }
            }
        }
    }
}

#Preview {
    DataView(title: "Heart Rate", outcome: NSNumber(97))
}
