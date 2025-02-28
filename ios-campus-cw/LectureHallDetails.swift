//
//  LectureHallDetails.swift
//  ios-campus-cw
//
//  Created by Knight.Wolf on 2025-02-28.
//

import SwiftUI

struct LectureHallDetails: View {
    let hallName: String
    
    private let pathwaySteps: [(title: String, description: String)] = [
        ("Step 1", "-> Enter the campus through the main entrance."),
        ("Step 2", "-> Proceed straight, passing the Student Center on your right."),
        ("Step 3", "-> Walk forward until you reach the courtyard."),
        ("Step 4", "-> Turn left at the library to continue to the next section."),
        ("Step 5", "-> Once you reach the second floor, walk down the hallway.")
    ]

    @State private var availableVotes: Int = 100
    @State private var unavailableVotes: Int = 0
    @State private var selectedStatus: LectureHallStatus = .available

    enum LectureHallStatus: String {
        case available = "Available"
        case unavailable = "Unavailable"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image("LecHall")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Lecture Hall Description")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Text(hallName)
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Lecture Hall Status Update")
                        .font(.headline)
                        .padding(.top, 5)
                    
                    Text("\"Vote to keep the lecture hall status accurate. The most-voted status will be shown as current availability.\"")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Button(action: {
                            selectedStatus = .available
                        }) {
                            ZStack {
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 24, height: 24)
                                
                                if selectedStatus == .available {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 16, height: 16)
                                }
                            }
                        }
                        
                        Text("Available")
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Text("\(availableVotes)%")
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: geometry.size.width, height: 10)
                                .foregroundColor(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                            
                            Rectangle()
                                .frame(width: geometry.size.width * CGFloat(availableVotes) / 100, height: 10)
                                .foregroundColor(Color.green)
                                .cornerRadius(5)
                        }
                    }
                    .frame(height: 10)
                    .padding(.vertical, 5)
                    
                    HStack {
                        Button(action: {
                            selectedStatus = .unavailable
                        }) {
                            ZStack {
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 24, height: 24)
                                
                                if selectedStatus == .unavailable {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 16, height: 16)
                                }
                            }
                        }
                        
                        Text("Unavailable")
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Text("\(unavailableVotes)%")
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: geometry.size.width, height: 10)
                                .foregroundColor(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                            
                            Rectangle()
                                .frame(width: geometry.size.width * CGFloat(unavailableVotes) / 100, height: 10)
                                .foregroundColor(Color.green)
                                .cornerRadius(5)
                        }
                    }
                    .frame(height: 10)
                    .padding(.vertical, 5)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                    .padding(.vertical, 15)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Pathway Description")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(pathwaySteps, id: \.title) { step in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(step.0)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            Text(step.1)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 30)
            }
        }
        .navigationTitle(hallName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LectureHallDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LectureHallDetails(hallName: "Lecture Hall A")
        }
    }
}
