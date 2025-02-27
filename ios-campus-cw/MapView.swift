//
//  MapView.swift
//  ios-campus-cw
//
//  Created by Knight.Wolf on 2025-02-26.
//

import SwiftUI

struct MapView: View {
    @State private var activeCategory: String? = nil
    @State private var selectedPin: (x: CGFloat, y: CGFloat, label: String)? = nil
    @Environment(\.dismiss) private var dismiss
   
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Category buttons - positioned below navigation bar with proper spacing
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        categoryButton(icon: "building.2", title: "Lec Halls", color: .blue, category: "LectureHalls")
                        categoryButton(icon: "person.fill", title: "Dean's Office", color: .blue, category: "DeansOffice")
                        categoryButton(icon: "book.fill", title: "Library", color: .blue, category: "Libraries")
                        categoryButton(icon: "p.circle.fill", title: "Parking", color: .blue, category: "Parking")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .zIndex(2) // Ensure categories are interactive
                }
                
                Divider()
                
                // Map content in its own container
                ZStack {
                    Image("mapPic")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .onTapGesture {
                            selectedPin = nil
                        }
                   
                    // Blue location dot (current position)
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 12, height: 12)
                        )
                        .offset(x: 0, y: -30)
                        .shadow(radius: 2)
    
                    // Show pins based on the active category
                    if activeCategory == "LectureHalls" {
                        PinView(label: "H1", systemImage: nil, xOffset: 40, yOffset: 80, selectedPin: $selectedPin)
                        PinView(label: "H2", systemImage: nil, xOffset: -90, yOffset: -120, selectedPin: $selectedPin)
                        PinView(label: "H3", systemImage: nil, xOffset: -65, yOffset: 50, selectedPin: $selectedPin)
                        PinView(label: "H4", systemImage: nil, xOffset: 80, yOffset: -175, selectedPin: $selectedPin)
                    }
                   
                    if activeCategory == "DeansOffice" {
                        PinView(label: "Dean's Office", systemImage: "person.fill", xOffset: 15, yOffset: -145, selectedPin: $selectedPin)
                    }
                   
                    if activeCategory == "Libraries" {
                        PinView(label: "Library 1", systemImage: "book.fill", xOffset: 70, yOffset: -10, selectedPin: $selectedPin)
                        PinView(label: "Library 2", systemImage: "book.fill", xOffset: -90, yOffset: -260, selectedPin: $selectedPin)
                    }
                   
                    if activeCategory == "Parking" {
                        PinView(label: "Parking", systemImage: "p.circle.fill", xOffset: 120, yOffset: 115, selectedPin: $selectedPin)
                    }
                   
                    // Pop-up above the selected pin
                    if let pin = selectedPin {
                        PinPopupView(label: pin.label, category: activeCategory ?? "")
                            .position(x: geometry.size.width / 2 + pin.x, y: geometry.size.height / 2 + pin.y - 60)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(1) // Lower z-index than the category buttons
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Campus Map")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Dashboard")
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
   
    private func categoryButton(icon: String, title: String, color: Color, category: String) -> some View {
        Button(action: {
            withAnimation {
                activeCategory = (activeCategory == category) ? nil : category
            }
        }) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(activeCategory == category ? color.opacity(0.5) : color.opacity(0.2))
            .foregroundColor(color)
            .cornerRadius(20)
        }
    }
}

// PinView and other view definitions remain the same

struct PinView: View {
    let label: String?
    let systemImage: String?
    let xOffset: CGFloat
    let yOffset: CGFloat
    @Binding var selectedPin: (x: CGFloat, y: CGFloat, label: String)?

    var body: some View {
        VStack {
            if let systemImage = systemImage {
                Image(systemName: systemImage)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 3)
            } else if let label = label {
                Text(label)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 3)
            }
           
            Triangle()
                .fill(Color.blue)
                .frame(width: 10, height: 10)
        }
        .offset(x: xOffset, y: yOffset)
        .onTapGesture {
            selectedPin = (xOffset, yOffset, label ?? "Unknown")
        }
    }
}

// The rest of your code stays the same...

// PinPopupView remains the same
struct PinPopupView: View {
    let label: String
    let category: String
   
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Image(getImageName())
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .frame(width: 180)
                    .clipped()
               
                VStack(alignment: .leading, spacing: 4) {
                    Text(label)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                   
                    HStack {
                        Text("Available")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                       
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10)
                       
                        NavigationLink {
                            destinationView
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20))
                                .foregroundColor(.gray.opacity(0.7))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            .frame(width: 280)
        }
    }
   
    func getImageName() -> String {
        switch category {
        case "LectureHalls": return "LecHall"
        case "DeansOffice": return "DeansOffice"
        case "Libraries": return "Libraries"
        case "Parking": return "ParkingImg"
        default: return "LecHall"
        }
    }
   
    @ViewBuilder
    private var destinationView: some View {
        switch category {
        case "LectureHalls":
            LectureHallDetails(hallName: label)
        case "DeansOffice":
            LectureHallDetails(hallName: label)
        case "Libraries":
            LectureHallDetails(hallName: label)
        case "Parking":
            LectureHallDetails(hallName: label)
        default:
            Text("Details not available")
        }
    }
}

// Triangle shape remains the same
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// Preview
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MapView()
        }
    }
}
