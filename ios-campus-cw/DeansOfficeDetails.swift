//
//  DeansOfficeDetails.swift
//  ios-campus-cw
//
//  Created by Knight.Wolf on 2025-02-27.
//


import SwiftUI

struct DeansOfficeDetails: View {
    let hallName: String
    let pathwaySteps: [(title: String, description: String)]
    
    @State private var availableVotes: Int = 100
    @State private var unavailableVotes: Int = 0
    @State private var selectedStatus: LectureHallStatus = .available
    
    enum LectureHallStatus: String {
        case available = "Available"
        case unavailable = "Unavailable"
    }
    
    init(hallName: String) {
        self.hallName = hallName
        
        // Default pathway steps
        self.pathwaySteps = [
            (title: "Step 1: Enter the Campus", description: "Begin at the main entrance of the campus."),
            (title: "Step 2: Walk Past the Student Center", description: "Head straight ahead, passing by the Student Center on your right."),
            (title: "Step 3: Reach the Courtyard", description: "Continue walking until you arrive at the courtyard area."),
            (title: "Step 4: Turn Left at the Library", description: "At the library, make a left turn to proceed toward the next section of the campus."),
            (title: "Step 5: Find Lecture Hall A", description: "Once on the second floor, walk down the hallway.")
        ]
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hall image - using LecHall from assets
                Image("DeansOffice")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Hall description
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
                
                // Status update section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Lecture Hall Status Update")
                        .font(.headline)
                        .padding(.top, 5)
                    
                    Text("\"Vote to keep the lecture hall status accurate. The most-voted status will be shown as current availability.\"")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    // Available option
                    HStack {
                        Button(action: {
                            selectedStatus = .available
                            updateVotes(for: .available)
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
                    
                    // Progress bar for Available
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
                    
                    // Unavailable option
                    HStack {
                        Button(action: {
                            selectedStatus = .unavailable
                            updateVotes(for: .unavailable)
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
                    
                    // Progress bar for Unavailable
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
                
                // Pathway description
                VStack(alignment: .leading, spacing: 15) {
                    Text("Pathway Description")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(0..<pathwaySteps.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(pathwaySteps[index].title)
                                .font(.subheadline)
                            Text("-> \(pathwaySteps[index].description)")
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
    
    // Function to update votes when user makes a selection
    private func updateVotes(for status: LectureHallStatus) {
        // Simple implementation to simulate voting
        switch status {
        case .available:
            availableVotes = min(100, availableVotes + 10)
            unavailableVotes = max(0, 100 - availableVotes)
        case .unavailable:
            unavailableVotes = min(100, unavailableVotes + 10)
            availableVotes = max(0, 100 - unavailableVotes)
        }
    }
}

// Preview provider for SwiftUI canvas
struct DeansOfficeDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DeansOfficeDetails(hallName: "Deans Office")
        }
    }
}
