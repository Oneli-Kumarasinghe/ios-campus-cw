//
//  SignUpStepOne.swift
//  ios-campus-cw
//
//  Created by Knight.Wolf on 2025-02-23.
//

import SwiftUI

struct SignUpStepOne: View {
    @State private var universityID = ""
    @State private var dob = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Welcome !")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Create your Member profile and get first access to the very best, inspiration and community.")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    TextField("University ID", text: $universityID)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(21)
                        .frame(width: 300)
                        .padding(.horizontal)

                    TextField("Date of Birth", text: $dob)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(21)
                        .frame(width: 300)
                        .padding(.horizontal)

                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(21)
                        .frame(width: 300)
                        .padding(.horizontal)

                    TextField("Phone Number", text: $phoneNumber)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(21)
                        .frame(width: 300)
                        .padding(.horizontal)

                    NavigationLink(destination: SignUpStepTwo()) {
                        Text("Next →")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 30)
                    
                    Text("By creating an account, you agree to Privacy Policy and Terms of Use.")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    VStack {
                        Text("Already have an account?")
                            .foregroundColor(.white)
                            .font(.footnote)

                        NavigationLink(destination: LoginView()) {
                            Text("Log In")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.top, 5)
            }
        }
    }
}

struct SignUpStepOne_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStepOne()
    }
}
