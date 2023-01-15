//
//  SettingsView.swift
//  dexter
//
//  Created by Dev on 06/01/2023.
//

import SwiftUI

struct Toggle: View {
    @EnvironmentObject var util: Util
    @State var on: Bool
    let field: String
    
    var body: some View {
        ZStack() {
            Circle()
                .fill(.white)
                .overlay(
                    Circle()
                        .stroke(!on ? .white : .black, lineWidth: 3)
                )
                .scaledToFit()
        }
        .aspectRatio(126/70, contentMode: .fit)
        .frame(
            maxWidth: 60,
            alignment: !on ? .leading : .trailing
        )
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 999)
                .fill(!on ? .black : Theme.yellow)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 999)
                .stroke(.black, lineWidth: 3)
        )
        .onTapGesture {
            on.toggle()
            switch field {
                case "notifications":
                    util.notifications.toggle()
                case "sound":
                    util.sound.toggle()
                case "haptics":
                    util.haptics.toggle()
                case "motion":
                    util.motion.toggle()
                default:
                    return
            }
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject var util: Util
    
    var body: some View {
        ZStack {
            Image("steampunk2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // User info
                GeometryReader { metrics in
                    VStack {
                        HStack {
                            // Image
                            ZStack {
                                Image("profile")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .padding(8)
                            .frame(
                                maxWidth: metrics.size.width * 0.3
                            )
                            .background(
                                Circle()
                                    .fill(.ultraThinMaterial)
                                    .opacity(0.5)
                            )
                            .overlay(
                                Circle()
                                    .stroke(.white)
                                    .opacity(0.4)
                            )
                            
                            // User text
                            VStack(alignment: .leading, spacing: 5) {
                                // Name
                                HStack {
                                    Text("Name:")
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(
                                            .system(
                                                size: 16,
                                                weight: .bold
                                            )
                                        )
                                    Text(util.username)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(
                                            .system(
                                                size: 14,
                                                weight: .semibold
                                            )
                                        )
                                }
                                
                                HStack {
                                    Text("Nickname:")
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(
                                            .system(
                                                size: 16,
                                                weight: .bold
                                            )
                                        )
                                    
                                    Text(util.nickname)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(
                                            .system(
                                                size: 14,
                                                weight: .semibold
                                            )
                                        )
                                }
                                
                                HStack {
                                    Text("Email:")
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(
                                            .system(
                                                size: 16,
                                                weight: .bold
                                            )
                                        )
                                    Text(util.email)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(
                                            .system(
                                                size: 14,
                                                weight: .semibold
                                            )
                                        )
                                }
                                
                                HStack {
                                    Text("Class:")
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(
                                            .system(
                                                size: 16,
                                                weight: .bold
                                            )
                                        )
                                    Text(util.class_)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(
                                            .system(
                                                size: 14,
                                                weight: .semibold
                                            )
                                        )
                                }
                            }
                            .padding(.leading, 10)
                        }
                        .padding(.bottom, 30)
                        
                        // Settings toggles
                        VStack(alignment: .leading, spacing: 30) {
                            HStack {
                                Text("APP LANGUAGE")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 24,
                                            weight: .heavy
                                        )
                                    )
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                
                                ZStack {
                                    Image("en")
                                        .resizable()
                                        .aspectRatio(126/70, contentMode: .fill)
                                }
                                .frame(
                                    maxWidth: 70
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(.black, lineWidth: 3)
                                )
                            }
                            
                            HStack {
                                Text("NOTIFICATIONS")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 24,
                                            weight: .heavy
                                        )
                                    )
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                
                                Toggle(on: util.notifications, field: "notifications")
                            }
                            
                            HStack {
                                Text("SOUND")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 24,
                                            weight: .heavy
                                        )
                                    )
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                
                                Toggle(on: util.sound, field: "sound")
                            }
                            
                            HStack {
                                Text("HAPTICS")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 24,
                                            weight: .heavy
                                        )
                                    )
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                
                                Toggle(on: util.haptics, field: "haptics")
                            }
                            
                            HStack {
                                Text("REDUCE MOTION")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 24,
                                            weight: .heavy
                                        )
                                    )
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                
                                Toggle(on: util.motion, field: "motion")
                            }
                            
                            HStack {
                                Text("Report a Bug")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 13,
                                            weight: .semibold
                                        )
                                    )
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 30)
                                    .frame(
                                        maxWidth: .infinity
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 999)
                                            .fill(.white)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 999)
                                            .stroke(.black, lineWidth: 3)
                                    )
                                
                                Spacer()
                                    .frame(width: 10)
                                
                                Text("Help")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 13,
                                            weight: .semibold
                                        )
                                    )
                                    .padding(5)
                                    .frame(
                                        maxWidth: .infinity
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 999)
                                            .fill(.white)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 999)
                                            .stroke(.black, lineWidth: 3)
                                    )
                            }
                        }
                        .padding(20)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: UIScreen.main.bounds.height * 0.5,
                            alignment: .topLeading
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.ultraThinMaterial)
                                .opacity(0.5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white)
                                .opacity(0.4)
                        )
                    }
                    
                }
                
            }
            .padding(20)
            .padding(.top, 50)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height,
                alignment: .top
            )
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(Util())
    }
}
