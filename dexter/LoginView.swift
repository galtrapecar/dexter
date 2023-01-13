//
//  LoginView.swift
//  dexter
//
//  Created by Dev on 31/12/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct ButtonPrimary : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 30,
                    bottom: 15,
                    trailing: 30
                )
            )
            .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 8)
            )
            .background(Theme.yellow)
            .cornerRadius(10)
            .foregroundColor(.black)
            .font(
                .system(
                    size: 20,
                    weight: Font.Weight.bold
                )
            )
    }
}

struct Login: View {
    @State private var username = ""
    @State private var password = ""
    @State var signInProcessing = false
    @State var error = ""
    @EnvironmentObject var util: Util
    
    func attempt_login() {
        if signInProcessing {
            return
        }
        signInProcessing = true
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            guard error == nil else {
                signInProcessing = false
                return login_failed(error: error?.localizedDescription ?? "")
            }

            switch result {
            case .none:
                login_failed(error: "")
            case .some(_):
                login_success()
            }
            
            signInProcessing = false
        }
    }

    func login_failed(error: String) {
        if (error != "") {
            self.error = error
        } else {
            self.error = "Something went wrong. Please try again."
        }
    }

    func login_success() {
        print("success")
        util.set_page(_page: Util.Page.home)
        print(util.page)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                TextField("", text: $username)
                    .frame(
                        height: 40.0
                    )
                    .font(
                        .system(
                            size: 13
                        )
                    )
                    .foregroundColor(.black)
                    .placeholder(when: username.isEmpty) {
                        Text("Student ID")
                            .foregroundColor(.gray)
                            .font(
                                .system(
                                    size: 13
                                )
                            )
                    }
                
                VStack {
                    Image("user")
                        .resizable()
                }
                .padding(7)
                .background(Theme.yellow)
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(.black, lineWidth: 4.0)
                )
                .frame(
                    width: 40.0,
                    height: 40.0,
                    alignment: .center
                )
                .cornerRadius(999)
            }
            .padding(.leading, 20.0)
            .background(.white)
            .cornerRadius(999)
            .padding(.top, 80.0)
            
            ZStack(alignment: .trailing) {
                SecureField("", text: $password)
                    .frame(
                        height: 40.0
                    )
                    .font(
                        .system(
                            size: 13
                        )
                    )
                    .foregroundColor(.black)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.gray)
                            .font(
                                .system(
                                    size: 13
                                )
                            )
                    }
                VStack {
                    Image("password")
                        .resizable()
                }
                .padding(7)
                .background(Theme.yellow)
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(.black, lineWidth: 4.0)
                )
                .frame(
                    width: 40.0,
                    height: 40.0,
                    alignment: .center
                )
                .cornerRadius(999)
            }
            .padding(.leading, 20.0)
            .background(.white)
            .cornerRadius(999)
            .padding(.top, 30.0)
            
            Spacer()
            
            if !signInProcessing {
                Button("LOGIN", action: attempt_login)
                    .modifier(ButtonPrimary())
            } else {
                Button(action: {}, label: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                })
                    .modifier(ButtonPrimary())
            }
            
            if (error != "") {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            } else {
                Text("Something went wrong. Please try again.")
                    .opacity(0)
            }
            
            Spacer()
            
            HStack {
                Text("Need help signing in?")
                    .font(
                        .system(
                            size: 11,
                            weight: Font.Weight.bold
                        )
                    )
                    .foregroundColor(.black)
                
                Text("Contact your School.")
                    .font(
                        .system(
                            size: 11,
                            weight: Font.Weight.bold
                        )
                    )
                    .background(
                        Color(.black)
                            .frame(height: 1)
                            .offset(y: 10)
                    )
                    .foregroundColor(.black)
            }
            
            Spacer()
                .frame(height: 20.0)
        }
        .padding(.horizontal, 20.0)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .modifier(FlatGlassView())
        .cornerRadius(15)
    }
}

struct LoginView: View {
    var body: some View {
        ZStack {
            Image("fiord_blur")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x: 150)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                    .frame(height: 50.0)
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                Spacer()
                    .frame(height: 50.0)
                
                Login()
                
                Spacer()
                    .frame(height: 50.0)
            }
            .padding(40)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height,
                alignment: .topTrailing
            )
            
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(Util())
    }
}
