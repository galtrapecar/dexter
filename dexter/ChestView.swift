//
//  ChestView.swift
//  dexter
//
//  Created by Gal Trapecar on 15/01/2023.
//

import SwiftUI

struct ChestCardPlaceholder: View {
    let index: Int
    
    var body: some View {
        ZStack {
            if index == 0 {
                Text("?")
                    .font(
                        .system(
                            size: 20,
                            weight: .heavy
                        )
                    )
                    .foregroundColor(.white)
                    .opacity(0.4)
            } else {
                Image(calculate_index(index: index))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .aspectRatio(476/690, contentMode: .fit)
        .background(
            RoundedRectangle(cornerRadius: 3)
                .fill(.ultraThinMaterial)
                .opacity(0.5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 3)
                .stroke(.white, lineWidth: 1)
                .opacity(0.5)
        )
    }
}

struct ChestCardView: View {
    @State private var isRotating = 0.0
    
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
                    
                    Image(calculate_index(index: util.card_from_chest))
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: UIScreen.main.bounds.width * 0.6
                        )
                    
                    VStack {
                        HStack(spacing: 20) {
                            ChestCardPlaceholder(index: util.cards_collected_from_chest[0])
                            ChestCardPlaceholder(index: util.cards_collected_from_chest[1])
                            ChestCardPlaceholder(index: util.cards_collected_from_chest[2])
                        }
                        .frame(
                            maxWidth: UIScreen.main.bounds.width * 0.6
                        )
                    }
                    .padding(20)
                    .padding(.bottom, 50)
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height,
                        alignment: .bottom
                    )
                }
                .onTapGesture {
                    util.chest_page_next()
                }
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
}


struct ChestStartView: View {
    @EnvironmentObject var util: Util
    
    @State private var animate = false
    @State private var isRotating = 0.0
    @State private var timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
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
                        .animation(animate ? Animation.linear(duration: 0.1).repeatForever(autoreverses: true) : Animation.easeOut(duration: 0.1), value: animate)
                        .onReceive(timer) { _ in
                            timer.upstream.connect().cancel()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.animate.toggle()
                                timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
                            }
                        }
                        .onTapGesture {
                            util.chest_page_next()
                        }
                    
                }
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
}

struct ChestView: View {
    @EnvironmentObject var util: Util
    
    var body: some View {
        switch util.chest_page_current {
        case .start:
            ChestStartView()
        case .card1:
            ChestCardView()
        case .card2:
            ChestCardView()
        case .card3:
            ChestCardView()
        default:
            ChestStartView()
        }
    }
}

struct ChestView_Previews: PreviewProvider {
    static var previews: some View {
        ChestView().environmentObject(Util())
    }
}
