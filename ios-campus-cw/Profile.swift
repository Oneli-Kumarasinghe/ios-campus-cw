//
//  Profile.swift
//  ios-campus-cw
//
//  Created by Oneli Kumarasinghe on 2025-02-24.
//

import Foundation
import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var bio: String = ""
    @State private var profileImage: UIImage? = nil
    @State private var backgroundImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showBackgroundPicker = false
    @State private var imagePickerType: ImagePickerType = .profile
    
    enum ImagePickerType {
        case profile
        case background
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "2196F3"),  // Light blue
                    Color(hex: "0D47A1")   // Dark blue
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            // Main content
            VStack(spacing: 0) {
                // Navigation bar
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Back")
                                .font(.system(size: 16, weight: .regular))
                        }
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Text("Edit Profile")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // Profile header with background waves
                ZStack(alignment: .bottom) {
                    // Custom background or default wave background
                    if let backgroundImage = backgroundImage {
                        Image(uiImage: backgroundImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 80)
                            .clipped()
                            .overlay(
                                // Edit background button
                                Button(action: {
                                    imagePickerType = .background
                                    showBackgroundPicker = true
                                }) {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .background(Circle().fill(Color.black.opacity(0.4)))
                                }
                                .padding(8),
                                alignment: .topTrailing
                            )
                    } else {
                        ZStack(alignment: .topTrailing) {
                            WaveBackground()
                                .frame(height: 80)
                            
                            // Edit background button
                            Button(action: {
                                imagePickerType = .background
                                showBackgroundPicker = true
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .background(Circle().fill(Color.black.opacity(0.4)))
                            }
                            .padding(8)
                        }
                    }
                    
                    // Profile image with centered camera icon
                    ZStack {
                        if let profileImage = profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                )
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                )
                        }
                        
                        // Camera button - centered
                        Button(action: {
                            imagePickerType = .profile
                            showImagePicker = true
                        }) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 15))
                                        .foregroundColor(.blue)
                                )
                        }
                    }
                    .offset(y: 40)
                }
                
                // Form fields
                VStack(spacing: 20) {
                    // Extra space for profile image overflow
                    Spacer()
                        .frame(height: 50)
                    
                    // Name field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        TextField("", text: $name)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    
                    // Username field
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Username")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("15/30")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        TextField("", text: $username)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    
                    // Bio field - with same style as username
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Bio")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("0/250")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        // Bio field styled like username
                        ZStack(alignment: .topLeading) {
                            // Semi-transparent background matching username field
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 120)
                            
                            if bio.isEmpty {
                                Text("Write something about yourself...")
                                    .foregroundColor(.white.opacity(0.6))
                                    .padding(.top, 14)
                                    .padding(.leading, 14)
                            }
                            
                            TextEditor(text: $bio)
                                .frame(height: 120)
                                .padding(6)
                                .scrollContentBackground(.hidden) // Hide default background
                                .background(Color.clear) // Make TextEditor background transparent
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    // Buttons
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Save profile changes
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save Changes")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                                .background(Color.black)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.bottom, 30)
                    
                    // Home indicator area
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color.white)
                        .frame(width: 120, height: 5)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $profileImage)
        }
        .sheet(isPresented: $showBackgroundPicker) {
            ImagePicker(selectedImage: $backgroundImage)
        }
        .navigationBarHidden(true)
    }
}

// Custom wave background
struct WaveBackground: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "0D2162"),  // Dark blue
                            Color(hex: "122C7A")   // Medium blue
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            // First wave pattern
            Path { path in
                let width = UIScreen.main.bounds.width
                let height: CGFloat = 80
                
                path.move(to: CGPoint(x: 0, y: height * 0.50))
                
                path.addCurve(
                    to: CGPoint(x: width, y: height * 0.60),
                    control1: CGPoint(x: width * 0.35, y: height * 0.80),
                    control2: CGPoint(x: width * 0.65, y: height * 0.40)
                )
                
                path.addLine(to: CGPoint(x: width, y: height))
                path.addLine(to: CGPoint(x: 0, y: height))
                path.closeSubpath()
            }
            .opacity(0.3)
            .foregroundColor(Color(hex: "1D3EA2"))
            
            // Second wave pattern
            Path { path in
                let width = UIScreen.main.bounds.width
                let height: CGFloat = 80
                
                path.move(to: CGPoint(x: 0, y: height * 0.65))
                
                path.addCurve(
                    to: CGPoint(x: width, y: height * 0.65),
                    control1: CGPoint(x: width * 0.30, y: height * 0.85),
                    control2: CGPoint(x: width * 0.70, y: height * 0.45)
                )
                
                path.addLine(to: CGPoint(x: width, y: height))
                path.addLine(to: CGPoint(x: 0, y: height))
                path.closeSubpath()
            }
            .opacity(0.2)
            .foregroundColor(Color(hex: "3253C1"))
        }
    }
}

// Helper for image picking
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}


