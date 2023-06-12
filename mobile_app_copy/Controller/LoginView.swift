//
//  LoginView.swift
//
//  Created by Ainhoa Mugica on 21.02.23.
//

import SwiftUI


struct LoginView: View {
    // Hold an error if one occurs so we can display it.
    @State var error: Error?
    @State var username: String = "demo"
    @State var password: String = "demopw"
    
    
    // Keep track of whether login is in progress.
    @State var isLoggingIn = false
    var body: some View {
        VStack {
            Image("LoginBack")
                .padding(.top, 0)
            Text("Welcome to the MongoDB Insurance App!")
                .font(.title)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.bottom, 25)
                .padding(.top, 25)
            
            Form {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            
            if isLoggingIn {
                ProgressView()
            }
            if let error = error {
                Text("Error: \(error.localizedDescription)")
            }
            
            
            Button("Login")
            {
                // Button pressed, so log in
                isLoggingIn = true
                app!.login(credentials: .emailPassword(email: username, password: password)) { result in
                    isLoggingIn = false
                    if case let .failure(error) = result {
                        print("Failed to log in: \(error.localizedDescription)")
                        // Set error to observed property so it can be displayed
                        self.error = error
                        return
                    }
                    // Other views are observing the app and will detect
                    // that the currentUser has changed. Nothing more to do here.
                    print("Logged in")
                }
            }.disabled(isLoggingIn)
    
                .padding()
                .font(.title3)
                .frame(width: 280, height:50)
                .background(Color.accentColor)
                .foregroundColor(.black)
                .cornerRadius(10)
           
                
            
            HStack{
                Text("Powered by ")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 25)
                   
                Image("LoginAtlas")
                    .padding(.bottom, 25)
                    .imageScale(.small)
            }
            .padding(.top, 25)
            .padding(.bottom, 25)
        }
        .background(CustomColor.BackGray.edgesIgnoringSafeArea(.all))
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
