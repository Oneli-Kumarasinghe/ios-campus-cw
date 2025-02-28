//
//  LoginView.swift
//  ios-campus-cw
//
//  Created by Knight.Wolf on 2025-02-23.
//


import SwiftUI

struct LoginView: View {
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.white]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Welcome back, Log In!")
                        .font(.system(size: 40, weight: .bold))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 60)
                    
                    TextField("Username", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(21)
                        .frame(width: 300)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    SecureField("Password", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(21)
                        .frame(width: 300)
                        .padding(.horizontal)
                    
                    NavigationLink(destination: DashboardView().navigationBarBackButtonHidden(true), isActive: $isLoggedIn) {
                        Button(action: {
                            self.isLoggedIn = true
                        }) {
                            Text("Log in")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .frame(width: 300)
                                .cornerRadius(21)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("OR")
                        .foregroundColor(.white)
                        .bold()
                    
                    SocialLoginButton(text: "Sign In with Facebook", color: Color.blue, icon: "facebook")
                    
                    SocialLoginButton(text: "Sign In with Google", color: Color.white, icon: "google")
                    
                    SocialLoginButton(text: "Sign In with Apple", color: Color.black, icon: "applelogo")
                    
                    Spacer()
                    
                    HStack {
                        Text("Don’t have an account yet?")
                            .foregroundColor(.white)
                        
                        NavigationLink(destination: SignUpStepOne()) {
                            Text("Sign Up")
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

struct SocialLoginButton: View {
    var text: String
    var color: Color
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color == .white ? .black : .white)
            Text(text)
                .foregroundColor(color == .white ? .black : .white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color)
        .cornerRadius(10)
        .frame(width: 300)
        .padding(.horizontal)
    }
}

struct SignUpView: View {
    var body: some View {
        Text("Sign Up Page")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
