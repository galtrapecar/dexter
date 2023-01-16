//
//  Chests.swift
//  dexter
//
//  Created by Dev on 07/01/2023.
//

import SwiftUI

enum ChestType {
    case wood
    case stone
    case gold
    
    var description : String {
        switch self {
            case .wood:     return "wood"
            case .stone:    return "stone"
            case .gold:     return "gold"
        }
    }
}

struct Chest: View {
    var openable: Bool
    var open: Bool
    var type: ChestType
    
    @State private var animate = false
    @State private var isRotating = 0.0
    @State private var timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if (openable && !open) {
                Image("godrays")
                    .resizable()
                    .frame(
                        width: 300.0,
                        height: 300.0
                    )
                    .scaledToFit()
                    .rotationEffect(.degrees(isRotating))
                    .onAppear {
                        withAnimation(.linear(duration: 5.0).speed(0.1).repeatForever(autoreverses: false)) {
                                isRotating = 360.0
                        }
                    }
                    .allowsHitTesting(false)
            }
            
            Image(open ? (type.description + "_open") : type.description)
                .resizable()
                .scaledToFit()
                .frame(
                    width: type == .gold ? 100.0 : 80.0,
                    height: type == .gold ? 100.0 : 80.0
                )
                .offset(x: animate && !open ? -5.0 : 0)
                .onAppear {
                    if (!openable || open) {
                        timer.upstream.connect().cancel()
                    }
                }
                .animation(animate && !open ? Animation.linear(duration: 0.1).repeatForever(autoreverses: true) : Animation.easeOut(duration: 0.1), value: animate)
                .onReceive(timer) { _ in
                    timer.upstream.connect().cancel()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        if (openable && !open){
                            self.animate.toggle()
                            timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
                        }
                    }
                }
                .onTapGesture {
                    if (openable && !open) {
                        util.chest_to_open = type
                        util.set_page(_page: .chest)
                    }
                }
        }
        .padding(10.0)
        .frame(
            width: type == .gold ? 120.0 : 100.0,
            height: type == .gold ? 120.0 : 100.0
        )
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 5)
    }
}

struct Chests: View {
    @EnvironmentObject var util: Util
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                HStack {
                    Chest(openable: util.get_points() >= 50.0, open: util.wood_collected, type: .wood).offset(y: 25.0)
                    Chest(openable: util.get_points() == 100,  open: util.gold_collected, type: .gold)
                    Chest(openable: util.get_points() >= 75.0, open: util.stone_collected, type: .stone).offset(y: 25.0)
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
        }
    }
}

struct Chests_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Util())
    }
}
