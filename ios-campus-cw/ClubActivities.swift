//
//  ClubActivities.swift
//  ios-campus-cw
//
//  Created by Oneli Kumarasinghe on 2025-02-26.
//
import Foundation

import SwiftUI



struct ClubActivitiesView: View {

    @Environment(\.presentationMode) var presentationMode

    @State private var searchText = ""

    @State private var cardAppearances: [Bool] = Array(repeating: false, count: 3)

    

    // Sample data for club activities

    let clubActivities = [

        ClubActivity(

            id: 1,

            clubName: "Campus Drama Club",

            title: "Standing Ovation for the Drama Club !",

            imageName: "drama_club",

            description: "A showcase at Nilsen-Lauritsen Theatre witnessed a standing performance.",

            shortDescription: "A showcase at Nilsen-Lauritsen Theatre witnessed a standing performance.",

            location: "Nilsen-Lauritsen Theatre"

        ),

        ClubActivity(

            id: 2,

            clubName: "Scrabble Club",

            title: "Word Wizards Wanted, Join the Scrabble Club Today!",

            imageName: "scrabble_club",

            description: "Challenge your vocabulary and strategic thinking with fellow word enthusiasts.",

            shortDescription: "Love word games? Test your vocabulary, strategy, and quick thinking at...",

            location: "Student Center, Room 102"

        ),

        ClubActivity(

            id: 3,

            clubName: "Campus Rugby Team",

            title: "Dominant Display, Thrilling Win !",

            imageName: "rugby_team",

            description: "Our rugby team secured an impressive victory against their rivals.",

            shortDescription: "Our rugby team secured an impressive victory today, despite struggling to keep up...",

            location: "Campus Stadium"

        )

    ]

    

    var body: some View {

        NavigationView {

            ZStack(alignment: .bottom) {

                ScrollView {

                    VStack(alignment: .leading, spacing: 16) {

                        // Header text

                        Text("Keep up with the latest feed !")

                            .font(.title2)

                            .fontWeight(.bold)

                            .padding(.horizontal)

                            .padding(.top, 8)

                        

                        // Club activity cards with scroll appearance

                        ForEach(Array(clubActivities.enumerated()), id: \.element.id) { index, activity in

                            ClubActivityCard(activity: activity)

                                .opacity(cardAppearances[index] ? 1 : 0)

                                .offset(y: cardAppearances[index] ? 0 : 20)

                                .onAppear {

                                    withAnimation(.easeOut(duration: 0.3).delay(Double(index) * 0.1)) {

                                        cardAppearances[index] = true

                                    }

                                }

                        }

                        

                        Spacer(minLength: 80) // Space for search bar

                    }

                    .padding(.bottom)

                }

                

                // Search bar at bottom

                HStack {

                    Image(systemName: "magnifyingglass")

                        .foregroundColor(.secondary)

                    

                    TextField("Search by club", text: $searchText)

                        .font(.body)

                    

                    if !searchText.isEmpty {

                        Button(action: {

                            searchText = ""

                        }) {

                            Image(systemName: "xmark.circle.fill")

                                .foregroundColor(.secondary)

                        }

                    }

                }

                .padding(10)

                .background(Color(.systemGray6))

                .cornerRadius(10)

                .padding(.horizontal)

                .padding(.bottom, 8)

                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)

            }

            .navigationBarTitle("Club Activities", displayMode: .inline)

            .navigationBarItems(leading:

                Button(action: {

                    presentationMode.wrappedValue.dismiss()

                }) {

                    HStack(spacing: 5) {

                        Image(systemName: "chevron.left")

                        Text("Back")

                    }

                }

            )

            .background(Color(.systemBackground))

        }

        .navigationViewStyle(StackNavigationViewStyle())

    }

}



// Club Activity Card View

struct ClubActivityCard: View {

    let activity: ClubActivity

    

    var body: some View {

        NavigationLink(destination: ClubActivityDetailView(activity: activity)) {

            VStack(alignment: .leading, spacing: 0) {

                // Image with overlay

                ZStack(alignment: .bottomLeading) {

                    // Image

                    Image(activity.imageName)

                        .resizable()

                        .aspectRatio(contentMode: .fill)

                        .frame(height: 160)

                        .clipped()

                    

                    // Club name and title overlay

                    VStack(alignment: .leading, spacing: 4) {

                        Text(activity.clubName)

                            .font(.subheadline)

                            .fontWeight(.medium)

                            .foregroundColor(.white)

                        

                        Text(activity.title)

                            .font(.headline)

                            .fontWeight(.bold)

                            .foregroundColor(.white)

                            .multilineTextAlignment(.leading)

                            .lineLimit(2)

                    }

                    .padding()

                    .background(

                        // Gradient overlay for better text visibility

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

                

                // Description and location

                VStack(alignment: .leading, spacing: 4) {

                    if !activity.location.isEmpty {

                        HStack(spacing: 4) {

                            Image(systemName: "mappin.circle.fill")

                                .font(.footnote)

                            Text(activity.location)

                                .font(.footnote)

                        }

                        .foregroundColor(.secondary)

                        .padding(.top, 8)

                    }

                    

                    Text(activity.shortDescription)

                        .font(.subheadline)

                        .foregroundColor(.secondary)

                        .lineLimit(2)

                        .padding(.top, 2)

                }

                .padding(.horizontal, 12)

                .padding(.vertical, 8)

            }

            .background(Color(.systemBackground))

            .cornerRadius(10)

            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)

        }

        .padding(.horizontal)

        .buttonStyle(PlainButtonStyle()) // This prevents the default button styling

    }

}





struct ClubActivityDetailView: View {

    let activity: ClubActivity

    

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 16) {

                // Club name at top

                Text(activity.clubName)

                    .font(.headline)

                    .foregroundColor(.blue)

                    .padding(.horizontal)

                

                // Activity title

                Text(activity.title)

                    .font(.system(size: 32, weight: .bold))

                    .padding(.horizontal)

                

                // Activity image

                Image(activity.imageName)

                    .resizable()

                    .aspectRatio(contentMode: .fill)

                    .frame(height: 220)

                    .cornerRadius(8)

                    .padding(.horizontal)

                

                // Full description

                Text(activity.description)

                    .font(.body)

                    .foregroundColor(.secondary)

                    .padding(.horizontal)

                

                // Additional details can be added here

                

                Spacer()

            }

            .padding(.top)

        }

        .navigationBarTitleDisplayMode(.inline)

    }

}













// Model for club activities

struct ClubActivity: Identifiable {

    let id: Int

    let clubName: String

    let title: String

    let imageName: String

    let description: String

    let shortDescription: String

    let location: String

}



let clubActivities = [

    ClubActivity(

        id: 1,

        clubName: "Campus Drama Club",

        title: "Standing Ovation for the Drama Club !",

        imageName: "drama_club",

        description: "Last night, the Drama Club delivered an unforgettable performance of Sanda Kinduri at Velum Pokuna Theatre, captivating the audience from start to finish. The hall was packed with students, faculty, and guests, all eager to witness the club's latest production. Ravindu Perera stole the show with a breathtaking performance, while the entire cast brought the story to life with impeccable acting, stunning visuals, and flawless stage presence.\n\nThe energy in the room was electric, with the audience responding to every dramatic twist, heartfelt moment, and comedic relief with enthusiasm.",

        shortDescription: "A showcase at Nilsen-Lauritsen Theatre witnessed a standing performance.",

        location: "Nilsen-Lauritsen Theatre"

    ),

    // ... other club activities

]



struct ClubActivitiesView_Previews: PreviewProvider {

    static var previews: some View {

        ClubActivitiesView()

            .preferredColorScheme(.light)

        

        ClubActivitiesView()

            .preferredColorScheme(.dark)

    }

}
