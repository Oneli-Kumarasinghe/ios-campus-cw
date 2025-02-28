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
    
    let clubActivities = [
        
        ClubActivity(
            
            id: 1,
            
            clubName: "Campus Drama Club",
            
            title: "Standing Ovation for the Drama Club !",
            
            imageName: "DramaPic",
            
            description: "Last night, the Drama Club delivered an unforgettable performance of Sanda Kinduri at Nelum Pokuna Theatre, captivating the audience from start to finish. The hall was packed with students, faculty, and guests, all eager to witness the club's latest production. Ravindu Perera stole the show with a breathtaking performance, while the entire cast brought the story to life with impeccable acting, stunning visuals, and flawless stage presence.",
            
            shortDescription: "A showcase at Nilsen-Lauritsen Theatre witnessed a standing performance.",
            
            location: "Nilsen-Lauritsen Theatre"
            
        ),
        
        ClubActivity(
            
            id: 2,
            
            clubName: "Scrabble Club",
            
            title: "Word Wizards Wanted, Join the Scrabble Club Today!",
            
            imageName: "ScrabblePic",
            
            description: "Last night, the Drama Club delivered an unforgettable performance of Sanda Kinduri at Nelum Pokuna Theatre, captivating the audience from start to finish. The hall was packed with students, faculty, and guests, all eager to witness the club's latest production. Ravindu Perera stole the show with a breathtaking performance, while the entire cast brought the story to life with impeccable acting, stunning visuals, and flawless stage presence.",
            
            shortDescription: "Love word games? Test your vocabulary, strategy, and quick thinking at...",
            
            location: "Student Center, Room 102"
            
        ),
        
        ClubActivity(
            
            id: 3,
            
            clubName: "Campus Rugby Team",
            
            title: "Dominant Display, Thrilling Win !",
            
            imageName: "FootBall",
            
            description: "Last night, the Drama Club delivered an unforgettable performance of Sanda Kinduri at Nelum Pokuna Theatre, captivating the audience from start to finish. The hall was packed with students, faculty, and guests, all eager to witness the club's latest production. Ravindu Perera stole the show with a breathtaking performance, while the entire cast brought the story to life with impeccable acting, stunning visuals, and flawless stage presence.",
            
            shortDescription: "Our rugby team secured an impressive victory today, despite struggling to keep up...",
            
            location: "Campus Stadium"
            
        )
        
    ]
    
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Club Activities")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
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
                            Spacer(minLength: 80)
                        }
                        .padding(.bottom)
                    }
                }
                .background(Color(.systemBackground))
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ClubActivityCard: View {

    let activity: ClubActivity

    

    var body: some View {

        NavigationLink(destination: ClubActivityDetailView(activity: activity)) {

            VStack(alignment: .leading, spacing: 0) {

                ZStack(alignment: .bottomLeading) {
                    Image(activity.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 160)
                        .clipped()

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
        .buttonStyle(PlainButtonStyle())

    }

}





struct ClubActivityDetailView: View {
    let activity: ClubActivity

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(activity.clubName)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                
                Text(activity.title)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.horizontal)

                Image(activity.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 220)
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Text(activity.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.top)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

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

]



struct ClubActivitiesView_Previews: PreviewProvider {

    static var previews: some View {

        ClubActivitiesView()
            .preferredColorScheme(.light)

    }

}
