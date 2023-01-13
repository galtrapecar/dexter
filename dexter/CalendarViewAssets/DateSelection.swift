//
//  SwiftUIView.swift
//  dexter
//
//  Created by Gal Trapecar on 12/01/2023.
//

import SwiftUI

struct DateSelection: View {
    @EnvironmentObject var util: Util
    
    func month_to_string(month: Int) -> String {
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "Noveber"
        case 12:
            return "December"
        default:
            return "Err"
        }
    }
    
    var body: some View {
        // Date
        HStack {
            // Date display
            VStack(alignment: .leading) {
                // Month year
                HStack(spacing: 3) {
                    Text(String(month_to_string(month: util.month)))
                        .font(
                            .system(
                                size: 20,
                                weight: .bold
                            )
                        )
                        .foregroundColor(.black)
                    Text(String(util.year))
                        .font(
                            .system(
                                size: 20,
                                weight: .medium
                            )
                        )
                        .foregroundColor(.black)
                }
                // Week
                Text("WEEK " + String(util.week))
                    .font(
                        .system(
                            size: 15,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            // Date selection
            HStack {
                // Left
                VStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                }
                .padding(7)
                .frame(
                    width: 28,
                    height: 28
                )
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.black)
                )
                .onTapGesture {
                    util.decrease_week()
                }
                
                // Today
                VStack {
                    Text("TODAY")
                        .foregroundColor(.white)
                        .font(
                            .system(
                                size: 12,
                                weight: .bold
                            )
                        )
                }
                .frame(
                    width: 28 * 2,
                    height: 28
                )
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.black)
                )
                .onTapGesture {
                    util.year = Calendar.current.component(.year, from: Date())
                    util.month = Calendar.current.component(.month, from: Date())
                    util.week = Calendar.current.component(.weekOfMonth, from: Date())
                }
                
                // Right
                VStack {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                }
                .padding(7)
                .frame(
                    width: 28,
                    height: 28
                )
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.black)
                )
                .onTapGesture {
                    util.increase_week()
                }
            }
        }
        .padding(20)
        .frame(
            maxWidth: .infinity,
            maxHeight: 70,
            alignment: .leading
        )
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white)
                .opacity(0.4)
        )
    }
}
