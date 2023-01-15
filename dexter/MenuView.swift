//
//  MenuView.swift
//  dexter
//
//  Created by Gal Trapecar on 14/01/2023.
//

import SwiftUI

struct MenuSubjectCard: View {
    let subject: String
    
    var body: some View {
        HStack() {
            Image(subject)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    maxWidth: 35
                )
            
            Text(subject)
                .foregroundColor(.black)
                .font(
                    .system(
                        size: 15,
                        weight: .bold
                    )
                )
                .textCase(.uppercase)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(15)
        .frame(
            maxWidth: .infinity,
            maxHeight: 70,
            alignment: .leading
        )
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Theme.from_string(input: subject))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(.black, lineWidth: 3)
                .opacity(0.2)
        )
    }
}

struct MenuView: View {
    @EnvironmentObject var util: Util
    
    var body: some View {
        ZStack {
            Image("beach")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // Content
            VStack {
                // Title
                HStack {
                    Text("SELECT A SUBJECT")
                        .foregroundColor(.black)
                        .font(
                            .system(
                                size: 23,
                                weight: .bold
                            )
                        )
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 70
                )
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.ultraThinMaterial)
                        .opacity(0.7)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.white)
                        .opacity(0.6)
                )
                
                // Subject cards
                ScrollView {
                    HStack {
                        MenuSubjectCard(subject: "art")
                            .onTapGesture {
                                util.selected_subject = "art"
                                util.page = .subject
                            }
                        MenuSubjectCard(subject: "biology")
                            .onTapGesture {
                                util.selected_subject = "biology"
                                util.page = .subject
                            }
                    }
                    HStack {
                        MenuSubjectCard(subject: "chemistry")
                            .onTapGesture {
                                util.selected_subject = "chemistry"
                                util.page = .subject
                            }
                        MenuSubjectCard(subject: "english")
                            .onTapGesture {
                                util.selected_subject = "english"
                                util.page = .subject
                            }
                    }
                    HStack {
                        MenuSubjectCard(subject: "geography")
                            .onTapGesture {
                                util.selected_subject = "geography"
                                util.page = .subject
                            }
                        MenuSubjectCard(subject: "history")
                            .onTapGesture {
                                util.selected_subject = "history"
                                util.page = .subject
                            }
                    }
                    HStack {
                        MenuSubjectCard(subject: "math")
                            .onTapGesture {
                                util.selected_subject = "math"
                                util.page = .subject
                            }
                        MenuSubjectCard(subject: "pe")
                            .onTapGesture {
                                util.selected_subject = "pe"
                                util.page = .subject
                            }
                    }
                    HStack {
                        MenuSubjectCard(subject: "physics")
                            .onTapGesture {
                                util.selected_subject = "physics"
                                util.page = .subject
                            }
                        MenuSubjectCard(subject: "spanish")
                            .onTapGesture {
                                util.selected_subject = "spanish"
                                util.page = .subject
                            }
                    }
                }
                .padding(.top, 20)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
