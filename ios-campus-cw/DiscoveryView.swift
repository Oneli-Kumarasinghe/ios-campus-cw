//
//  DiscoveryView.swift
//  ios-campus-cw
//
//  Created by Samadhi Gunawardhana on 2025-02-26.
//
import SwiftUI

struct DiscoveryView: View {
    @State private var selectedTip: TipType? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header with back button
                HStack {
                    Text("Discovery")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Tips Section
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        
                        // App Introduction
                        NavigationLink(
                            destination: AppIntroCarouselView(),
                            tag: TipType.appIntroduction,
                            selection: $selectedTip
                        ) {
                            TipCard(
                                icon: "lightbulb.fill",
                                iconBackground: .yellow,
                                title: "APP INTRODUCTION",
                                subtitle: "Getting Started with the Campus App",
                                description: "Learn how to set your account, navigate fea..."
                            ) {
                                selectedTip = .appIntroduction
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.top, 10)
                        
                        // Club Creation
                        NavigationLink(
                            destination: ClubCreationCarouselView(),
                            tag: TipType.clubCreation,
                            selection: $selectedTip
                        ) {
                            TipCard(
                                icon: "person.3.fill",
                                iconBackground: .blue,
                                title: "CAMPUS TIPS",
                                subtitle: "Starting a Club on Campus",
                                description: "Step-by-step guide to creating and managin..."
                            ) {
                                selectedTip = .clubCreation
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Student Discounts
                        NavigationLink(
                            destination: DiscountsCarouselView(),
                            tag: TipType.studentDiscounts,
                            selection: $selectedTip
                        ) {
                            TipCard(
                                icon: "gift.fill",
                                iconBackground: .orange,
                                title: "CAMPUS TIPS",
                                subtitle: "Find Student Discount and Perks",
                                description: "Unlock exclusive student discounts, free re..."
                            ) {
                                selectedTip = .studentDiscounts
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Essential Apps
                        NavigationLink(
                            destination: EssentialAppsCarouselView(),
                            tag: TipType.essentialApps,
                            selection: $selectedTip
                        ) {
                            TipCard(
                                icon: "app.gift.fill",
                                iconBackground: .green,
                                title: "STUDENT LIFE",
                                subtitle: "Essential Apps & Tools for Students",
                                description: "List of must-have apps and digital tools..."
                            ) {
                                selectedTip = .essentialApps
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                
            }
            .navigationBarHidden(true)
        }
    }
}

enum TipType {
    case appIntroduction
    case clubCreation
    case studentDiscounts
    case essentialApps
}

struct TipCard: View {
    var icon: String
    var iconBackground: Color
    var title: String
    var subtitle: String
    var description: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: 15) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(iconBackground)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    )
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
        .buttonStyle(PlainButtonStyle())
    }
}

// Generic Carousel View which can be reused
struct GenericCarouselView: View {
    @State private var currentPage: Int
    @Environment(\.presentationMode) var presentationMode
    var title: String
    var cards: [CarouselCardData]
    
    init(title: String, cards: [CarouselCardData], initialPage: Int = 1) {
        self.title = title
        self.cards = cards
        self._currentPage = State(initialValue: initialPage)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
            HStack {
                Button(action: {
                    // This will pop the view and return to the previous screen
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                        Text("Back")
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Carousel
            TabView(selection: $currentPage) {
                ForEach(0..<cards.count, id: \.self) { index in
                    CarouselCard(
                        title: cards[index].title,
                        description: cards[index].description,
                        currentPage: index + 1,
                        totalPages: cards.count
                    )
                    .tag(index + 1)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentPage)
        }
        .navigationBarHidden(true)
    }
}

// Data model for carousel cards
struct CarouselCardData {
    var title: String
    var description: String
}

// Carousel Card View
struct CarouselCard: View {
    var title: String
    var description: String
    var currentPage: Int
    var totalPages: Int
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            // This would be your actual image in a real app
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
                .overlay(
                    Text("Illustration \(currentPage)")
                        .foregroundColor(.gray)
                )
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.secondary)
            
            // Pagination dots
            HStack(spacing: 8) {
                ForEach(1...totalPages, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
}

// Specific Carousel Views for each type of tip

// 1. App Introduction Carousel
struct AppIntroCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let appIntroCards = [
        CarouselCardData(
            title: "Welcome to Campus App 🎓",
            description: "Your all-in-one solution for university life! Navigate classes, clubs, events, and resources right from your phone."
        ),
        CarouselCardData(
            title: "Create Your Profile 📝",
            description: "Set up your student profile to personalize your experience. Add your major, interests, and preferences to get custom recommendations."
        ),
        CarouselCardData(
            title: "Discover Campus Resources 🔍",
            description: "Find study spaces, dining options, health services, and more. Check hours, locations, and availability in real-time."
        ),
        CarouselCardData(
            title: "Stay Connected 📱",
            description: "Get notifications about classes, events, and important deadlines. Never miss an announcement again!"
        )
    ]
    
    var body: some View {
        GenericCarouselView(title: "App Introduction", cards: appIntroCards)
    }
}

// 2. Club Creation Carousel
struct ClubCreationCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let clubCreationCards = [
        CarouselCardData(
            title: "Bring Your Idea to Life 💡",
            description: "Have a passion or interest you want to share? Starting a club is a great way to connect with like-minded students! All you need is an idea and the enthusiasm to lead."
        ),
        CarouselCardData(
            title: "Gather Your Founding Members 👥",
            description: "Most campuses require a minimum number of members to officially register a club. Reach out to friends, classmates, or post on student forums to build your founding team."
        ),
        CarouselCardData(
            title: "Get Official Recognition 🏛️",
            description: "To make your club official, submit a proposal to the student affairs office! Include your club's purpose, structure, and leadership roles. Approval gives you access to resources and funding!"
        ),
        CarouselCardData(
            title: "Find a Faculty Advisor 👨‍🏫",
            description: "Some universities require clubs to have a faculty advisor. Look for a professor or staff member who shares your club's interests and can offer guidance and support."
        ),
        CarouselCardData(
            title: "Finally, Spread the Word 📣",
            description: "Use social media, campus bulletin boards, and the student app's Club Activities section to promote your club and get people excited to join!"
        )
    ]
    
    var body: some View {
        GenericCarouselView(title: "Club Creation", cards: clubCreationCards)
    }
}

// 3. Student Discounts Carousel
struct DiscountsCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let discountCards = [
        CarouselCardData(
            title: "Student ID = Savings 💰",
            description: "Your student ID card is your ticket to savings! Many businesses offer discounts when you show your valid student ID."
        ),
        CarouselCardData(
            title: "Digital Discounts 💻",
            description: "Get special pricing on software, streaming services, and online subscriptions with your .edu email address."
        ),
        CarouselCardData(
            title: "Local Savings 🍔",
            description: "Restaurants, coffee shops, and stores near campus often offer student deals. Check the app's local deals section for up-to-date offers."
        ),
        CarouselCardData(
            title: "Travel Perks ✈️",
            description: "From bus passes to airline tickets, being a student can save you money on transportation and accommodations when traveling."
        )
    ]
    
    var body: some View {
        GenericCarouselView(title: "Student Discounts", cards: discountCards)
    }
}

// 4. Essential Apps Carousel
struct EssentialAppsCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let appCards = [
        CarouselCardData(
            title: "Productivity Apps 📊",
            description: "Stay organized with note-taking, to-do lists, and calendar apps that sync across all your devices."
        ),
        CarouselCardData(
            title: "Study Tools 📚",
            description: "Flashcards, citation generators, and subject-specific apps to help you ace your classes."
        ),
        CarouselCardData(
            title: "Financial Management 💵",
            description: "Track expenses, create budgets, and manage your student loans with financial apps designed for students."
        ),
        CarouselCardData(
            title: "Health & Wellness 🧘",
            description: "Apps for fitness, meditation, sleep tracking, and mental health support to keep you balanced during the school year."
        ),
        CarouselCardData(
            title: "Campus-Specific Apps 🏛️",
            description: "Don't forget apps created specifically for your university, like library resources, shuttle tracking, or dining services."
        )
    ]
    
    var body: some View {
        GenericCarouselView(title: "Essential Apps", cards: appCards)
    }
}

// Preview
struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView()
    }
}
