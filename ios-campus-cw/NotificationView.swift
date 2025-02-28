//
//  NotificationViewController.swift
//  ios-campus-cw
//
//  Created by Samadhi Gunawardhana on 2025-02-23.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    NotificationCard(
                        icon: "book.fill",
                        iconColor: .red,
                        title: "Library Occupancy Alert",
                        message: "Main Library is currently at 85% capacity",
                        timeAgo: "2 mins ago"
                    )
                    
                    NotificationCard(
                        icon: "clock.fill",
                        iconColor: .orange,
                        title: "Schedule Update",
                        message: "CS301 lecture moved to Room 204",
                        timeAgo: "10 mins ago"
                    )
                    
                    NotificationCard(
                        icon: "cup.and.saucer.fill",
                        iconColor: .yellow,
                        title: "Canteen Status",
                        message: "Short waiting time at Main Canteen",
                        timeAgo: "15 mins ago"
                    )
                    
                    NotificationCard(
                        icon: "building.2.fill",
                        iconColor: .green,
                        title: "Building Access",
                        message: "Engineering Building closing in 30 minutes",
                        timeAgo: "20 mins ago"
                    )
                }
                .padding()
            }
            .navigationTitle("Notifications")
        }
    }
}

struct NotificationCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let message: String
    let timeAgo: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.system(size: 20))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(timeAgo)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(UIColor.systemGray5), lineWidth: 1)
        )
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
