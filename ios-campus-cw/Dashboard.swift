//
//  Dashboard.swift
//  ios-campus-cw
//
//  Created by Oneli Kumarasinghe on 2025-02-13.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            EditProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(1)
            
            NotificationView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(2)
        }
    }
}

struct HomeView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Menu Grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        NavigationLink(destination: LectureScheduleView()) {
                            MenuCard(
                                title: "Lecture Schedule",
                                icon: "book.fill",
                                gradient: [Color(hex: "2196F3"), Color(hex: "0D47A1")] // Updated gradient
                            )
                        }
                        
                        NavigationLink(destination: ClubActivitiesView()) {
                            MenuCard(
                                title: "Club Activities",
                                icon: "sparkles.tv.fill",
                                gradient: [Color(hex: "2196F3"), Color(hex: "0D47A1")] // Updated gradient
                            )
                        }
                        
                        NavigationLink(destination: Text("Map")) {
                            MenuCard(
                                title: "Map",
                                icon: "map.fill",
                                gradient: [Color(hex: "2196F3"), Color(hex: "0D47A1")] // Updated gradient
                            )
                        }
                        
                        NavigationLink(destination: DiscoveryView()) {
                            MenuCard(
                                title: "Discovery",
                                icon: "magnifyingglass.circle.fill",
                                gradient: [Color(hex: "2196F3"), Color(hex: "0D47A1")] // Updated gradient
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Recommended Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recommended For You")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<3) { _ in
                                    RecommendationCard()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct MenuCard: View {
    let title: String
    let icon: String
    let gradient: [Color]
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: gradient),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    VStack(spacing: 12) {
                        Image(systemName: icon)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        
                        Text(title)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                )
                .frame(height: 120)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
    }
}

struct RecommendationCard: View {
    var body: some View {
        NavigationLink(destination: Text("Recommendation Details")) {
            VStack(alignment: .leading) {
                Image("lecture_hall") // Replace with your image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 280, height: 160)
                    .clipped()
                    .cornerRadius(12)
                    .overlay(
                        VStack {
                            Spacer()
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.black.opacity(0.7),
                                            Color.black.opacity(0)
                                        ]),
                                        startPoint: .bottom,
                                        endPoint: .top
                                    )
                                )
                        }
                        .cornerRadius(12)
                    )
            }
            .frame(width: 280)
        }
    }
}

// Helper extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
