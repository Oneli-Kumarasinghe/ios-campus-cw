//
//  SignUpStepTwo.swift
//  ios-campus-cw
//
//  Created by Knight.Wolf on 2025-02-23.
//


import SwiftUI

struct SignUpStepTwo: View {
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
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

                TextField("User Name", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(21)
                    .frame(width: 350)
                    .padding(.horizontal)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(21)
                    .frame(width: 350)
                    .padding(.horizontal)

                SecureField("Re Enter Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(21)
                    .frame(width: 350)
                    .padding(.horizontal)
                
                Button(action: {
                    
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(21)
                        .frame(width: 350)
                        .padding(.horizontal)
                }
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
        .navigationBarBackButtonHidden(false)
    }
}

struct SignUpStepTwo_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStepTwo()
    }
}