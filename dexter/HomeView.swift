//
//  HomeView.swift
//  dexter
//
//  Created by Dev on 31/12/2022.
//

import SwiftUI

struct Target: Shape {
    var depth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: depth))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - depth))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}

struct HomeView: View {
    @EnvironmentObject var util: Util
    
    var body: some View {
        ZStack {
            Image("forest4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack {
                    ProgressBar().environmentObject(util)
                    Spacer()
                    Chests().environmentObject(util)
                    Spacer()
                    Assignments().environmentObject(util)
                }
                .padding(.horizontal, 20.0)
                .frame(
                    width: UIScreen.main.bounds.width
                )
            }
            .padding(.top, 50.0)
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


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(Util())
    }
}
