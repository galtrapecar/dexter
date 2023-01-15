//
//  ChestView.swift
//  dexter
//
//  Created by Gal Trapecar on 15/01/2023.
//

import SwiftUI

struct ChestView: View {
    @EnvironmentObject var util: Util

    @State private var animate = false
    @State private var isRotating = 0.0
    @State private var timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
//    @State var
    
    var body: some View {
        ZStack {
            Image("treasure1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x: -130)
                .edgesIgnoringSafeArea(.all)
            
            // Chest
            VStack {
                ZStack {
                    Image("godrays")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: UIScreen.main.bounds.width * 2
                        )
                        .scaledToFit()
                        .rotationEffect(.degrees(isRotating))
                        .onAppear {
                            withAnimation(.linear(duration: 5.0).speed(0.1).repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                            }
                        }
                    
                    Image(util.chest_to_open.description)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 240.0
                        )
                        .offset(x: animate ? -5.0 : 0)
                        .animation(animate ? Animation.linear(duration: 0.1).repeatForever(autoreverses: true) : Animation.easeOut(duration: 0.1))
                        .onReceive(timer) { _ in
                            timer.upstream.connect().cancel()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.animate.toggle()
                                timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
                            }
                        }
                    
                    VStack {
                        Text("OPEN")
                            .foregroundColor(.black)
                            .modifier(ButtonPrimary())
                            .scaleEffect(1.3)
                            .onTapGesture {
                                
                            }
                    }
                    .padding(.bottom, 170)
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height,
                        alignment: .bottom
                    )
                }
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
}

struct ChestView_Previews: PreviewProvider {
    static var previews: some View {
        ChestView().environmentObject(Util())
    }
}
