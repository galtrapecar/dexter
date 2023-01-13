//
//  File.swift
//  dexter
//
//  Created by Dev on 05/01/2023.
//

import SwiftUI

struct ProgressBar: View {
    @EnvironmentObject var util: Util
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                // Background Bar
                ZStack {
                    // Yellow bar
                    GeometryReader { metrics in
                        VStack {
                            // Reflection bar
                            GeometryReader { metrics in
                                RoundedRectangle(cornerRadius: 999)
                                    .fill(Color.white.opacity(0.7))
                                    .frame(
                                        width: (metrics.size.width - 10.0),
                                        height: 3.0
                                    )
                            }
                            .frame(
                                maxHeight: .infinity
                            )
                            .padding(.top, 3.0)
                        }
                        .frame(
                            width: metrics.size.width * (util.get_points() / 100),
                            height: metrics.size.height
                        )
                        .background(Theme.yellow)
                        .cornerRadius(999)
                    }
                    .frame(
                        height: (25.0 - 6.0)
                    )
                    
                    // Targets
                    GeometryReader { metrics in
                        HStack {
                            Spacer().frame(
                                width: (metrics.size.width / 2) - 30.0
                            )
                            // Target 50%
                            Rectangle()
                                .fill(Color.black.opacity(0.3))
                                .frame(
                                    width: 30.0,
                                    height: 50.0
                                )
                                .mask(Target(depth: 60))
                            
                            // Target 75%
                            HStack {
                                Rectangle()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(
                                        width: 30.0,
                                        height: 50.0
                                    )
                                    .mask(Target(depth: 60))
                            }
                            .frame(
                                maxWidth: .infinity,
                                alignment: .center
                            )
                            .padding(.trailing, 30.0)
                            
                        }
                        .frame(
                            width: metrics.size.width,
                            alignment: .leading
                        )
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 25.0,
                    alignment: .leading
                )
                .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .stroke(.black, lineWidth: 6)
                )
                .background(Theme.dark_gray)
                .cornerRadius(999.0)
            }
            .padding(.leading, 30.0)
            
            // Score track
            GeometryReader { metrics in
                ZStack {
                    // Score label
                    ZStack {
                        // Triangle
                        GeometryReader { metrics in
                            Path { path in
                                path.move(to: CGPoint(x : (metrics.size.width / 2) - 7, y : 0))
                                path.addLine (to : CGPoint(x: (metrics.size.width / 2) + 7, y : 0))
                                path.addLine (to : CGPoint(x: (metrics.size.width / 2), y : -6))
                                path.addLine (to : CGPoint(x: (metrics.size.width / 2) - 7, y : 0))
                            }
                            .fill(Color.white)
                        }
                        
                        Text(Int(util.get_points()).description + "/100")
                            .font(
                                .system(
                                    size: 9,
                                    weight: Font.Weight.bold
                                )
                            )
                            .foregroundColor(.black)
                    }
                    .frame(
                        width: 50.0,
                        height: 25.0
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 3.0)
                            .fill(Theme.yellow)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 3.0)
                            .stroke(.black, lineWidth: 2.0)
                    )
                }
                .padding(.leading, (metrics.size.width * util.get_points() / 100) >= metrics.size.width ? metrics.size.width - 35.0 : (metrics.size.width * util.get_points() / 100) - 25.0)
                .padding(.top, 64.0)
                .frame(
                    width: metrics.size.width,
                    height: metrics.size.height,
                    alignment: .leading
                )
            }
            .padding(.leading, 30.0)
            
            // EXP icon
            Image("shield")
                .resizable()
                .frame(width: 50.0, height: 50.0)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 50.0,
            alignment: .leading
        )
    }
}

struct ProgresBar_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(Util())
    }
}
