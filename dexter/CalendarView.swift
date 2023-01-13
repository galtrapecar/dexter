//
//  CalendarView.swift
//  dexter
//
//  Created by Dev on 06/01/2023.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var util: Util
    
    var body: some View {
        ZStack {
            Image("forest3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 15) {
                    DateSelection()
                    Schedule()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
                .padding(20)
                .padding(.top, 50)
            }
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(Util())
    }
}
