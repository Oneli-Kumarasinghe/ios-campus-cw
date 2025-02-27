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
    @State private var viewMode: ViewMode = .today
    
    enum ViewMode: String, CaseIterable {
        case today = "Today"
        case week = "Week"
        case month = "Month"
    }
    
    let lectures = [
        Lecture(title: "Mobile App Development", room: "CS-301", professor: "Prof. Johnson", startTime: "9:00", endTime: "10:30", icon: "iphone", color: Color.pink.opacity(0.2)),
        Lecture(title: "UI/UX Design Principles", room: "DES-105", professor: "Prof. Zhang", startTime: "11:00", endTime: "12:30", icon: "paintbrush", color: Color.orange.opacity(0.2)),
        Lecture(title: "Database Systems", room: "CS-201", professor: "Prof. Martinez", startTime: "14:00", endTime: "15:30", icon: "server.rack", color: Color.green.opacity(0.2)),
        Lecture(title: "Research Methods", room: "RS-401", professor: "Prof. Wilson", startTime: "16:00", endTime: "17:30", icon: "magnifyingglass", color: Color.blue.opacity(0.2))
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom navigation bar with back button
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        // Back button that matches the design
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.blue)
                                Text("Back")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 17, weight: .regular))
                            }
                            .padding(8)
                            //.background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Calendar action
                        }) {
                            Image(systemName: "calendar")
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Title added separately
                    Text("Lecture Schedule")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    // Date picker section
                    VStack(alignment: .leading) {
                        HStack {
                            Text(formattedDate())
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .overlay(
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundColor(Color(.systemGray4)),
                            alignment: .bottom
                        )
                    }
                }
                
                // View mode selector
                HStack {
                    ForEach(ViewMode.allCases, id: \.self) { mode in
                        Button(action: {
                            viewMode = mode
                        }) {
                            Text(mode.rawValue)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(viewMode == mode ? Color.blue : Color.clear)
                                .foregroundColor(viewMode == mode ? .white : .blue)
                                .cornerRadius(8)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Lectures section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Today's Lectures")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(lectures) { lecture in
                                LectureCard(lecture: lecture)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter.string(from: selectedDate)
    }
}

struct LectureCard: View {
    let lecture: Lecture
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(lecture.color)
                    .frame(width: 40, height: 40)
                
                Image(systemName: lecture.icon)
                    .foregroundColor(getIconColor(for: lecture.color))
            }
            
            VStack(alignment: .leading, spacing: 2) {
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
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lecture.color, lineWidth: 1)
        )
    }
    
    func getIconColor(for backgroundColor: Color) -> Color {
        // Return a slightly darker version of the background color for the icon
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

struct Dashboard: View {
    var body: some View {
        Dashboard()
    }
}

struct LectureScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        LectureScheduleView()
    }
}









// This would typically be in your App.swift or SceneDelegate.swift

