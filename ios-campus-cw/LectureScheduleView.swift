//
//  LectureScheduleView.swift
//  ios-campus-cw
//
//  Created by Samadhi Gunawardhana on 2025-02-26.
//
import SwiftUI

struct Lecture: Identifiable {
    let id = UUID()
    let title: String
    let room: String
    let professor: String
    let startTime: String
    let endTime: String
    let icon: String
    let color: Color
}

struct LectureScheduleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Lecture Schedules")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                ScrollView {
                    VStack {
                        ForEach(lectures(), id: \.id) { lecture in
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(lecture.color)
                                        .frame(width: 40, height: 40)
                                    
                                    Image(systemName: lecture.icon)
                                        .foregroundColor(self.getIconColor(for: lecture.color))
                                }
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(lecture.title)
                                        .font(.headline)
                                    
                                    Text("Room: \(lecture.room)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text(lecture.professor)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                
                                Text("\(lecture.startTime) - \(lecture.endTime)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                                    .shadow(radius: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lecture.color, lineWidth: 1)
                            )
                        }
                    }
                    .padding()
                }
                .padding(.top)
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }

    func lectures() -> [Lecture] {
        [
            Lecture(title: "Mobile App Development", room: "CS-301", professor: "Prof. Johnson", startTime: "9:00", endTime: "10:30", icon: "iphone", color: Color.pink.opacity(0.2)),
            Lecture(title: "UI/UX Design Principles", room: "DES-105", professor: "Prof. Zhang", startTime: "11:00", endTime: "12:30", icon: "paintbrush", color: Color.orange.opacity(0.2)),
            Lecture(title: "Database Systems", room: "CS-201", professor: "Prof. Martinez", startTime: "14:00", endTime: "15:30", icon: "server.rack", color: Color.green.opacity(0.2)),
            Lecture(title: "Research Methods", room: "RS-401", professor: "Prof. Wilson", startTime: "16:00", endTime: "17:30", icon: "magnifyingglass", color: Color.blue.opacity(0.2))
        ]
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter.string(from: selectedDate)
    }

    func getIconColor(for backgroundColor: Color) -> Color {
        if backgroundColor == Color.pink.opacity(0.2) {
            return Color.pink
        } else if backgroundColor == Color.orange.opacity(0.2) {
            return Color.orange
        } else if backgroundColor == Color.green.opacity(0.2) {
            return Color.green
        } else {
            return Color.blue
        }
    }
}

struct LectureScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        LectureScheduleView()
    }
}
