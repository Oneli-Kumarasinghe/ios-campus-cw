//
//  Profile.swift
//  ios-campus-cw
//
//  Created by Oneli Kumarasinghe on 2025-02-24.
//

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
        ScrollView {
            VStack(spacing: 20) {
                Text("Edit Profile")
                    .font(.title)
                    .bold()
                
                // Profile header with background
                if let backgroundImage = backgroundImage {
                    Image(uiImage: backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .cornerRadius(10)
                        .overlay(
                            Button(action: {
                                imagePickerType = .background
                                showBackgroundPicker = true
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .padding(10),
                            alignment: .topTrailing
                        )
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 150)
                        .cornerRadius(10)
                        .overlay(
                            Button(action: {
                                imagePickerType = .background
                                showBackgroundPicker = true
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .padding(10),
                            alignment: .topTrailing
                        )
                }
                
                // Profile image
                VStack {
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                    }
                    
                    Button(action: {
                        imagePickerType = .profile
                        showImagePicker = true
                    }) {
                        Text("Change Profile Picture")
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }
                }
                
                // Name field
                VStack(alignment: .leading) {
                    Text("Name")
                    TextField("Enter your name", text: $name)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                }
                
                // Username field
                VStack(alignment: .leading) {
                    Text("Username")
                    TextField("Enter username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                }
                
                // Bio field
                VStack(alignment: .leading) {
                    Text("Bio")
                    TextEditor(text: $bio)
                        .frame(height: 100)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                }
                
                // Action buttons
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Save changes
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $profileImage)
        }
        .sheet(isPresented: $showBackgroundPicker) {
            ImagePicker(selectedImage: $backgroundImage)
        }
    }
}

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




