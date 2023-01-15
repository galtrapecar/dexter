//
//  CollectionView.swift
//  dexter
//
//  Created by Dev on 06/01/2023.
//

import SwiftUI

func calculate_index(index: Int) -> String {
    if (index < 10) {
        return "0" + String(index)
    }
    return String(index)
}

struct Card: View {
    @EnvironmentObject var util: Util
    let index: Int
    
    var body: some View {
        VStack {
            if (util.collected[index] != nil && util.collected[index]!) {
                Image(calculate_index(index: index))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Text("?")
                    .font(
                        .system(
                            size: 20,
                            weight: .heavy
                        )
                    )
                    .foregroundColor(.white)
                    .opacity(0.4)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .cornerRadius(3)
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
        .onTapGesture {
            if (util.collected[index] != nil && util.collected[index]!) {
                util.showing_card = true
                util.showing_card_index = index
            }
        }
    }
}

struct Common: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("COMMON")
                .font(
                    .system(
                        size: 30,
                        weight: .heavy
                    )
                )
                .foregroundColor(.black)
            
            // Cards
            VStack(spacing: 30) {
                HStack(spacing: 30) {
                    Card(index: 30)
                    Card(index: 29)
                    Card(index: 28)
                }
                HStack(spacing: 30) {
                    Card(index: 27)
                    Card(index: 26)
                    Card(index: 25)
                }
                HStack(spacing: 30) {
                    Card(index: 24)
                    Card(index: 23)
                    Card(index: 22)
                }
                HStack(spacing: 30) {
                    Card(index: 21)
                    Card(index: 20)
                    Card(index: 19)
                }
                HStack(spacing: 30) {
                    Card(index: 18)
                    Card(index: 17)
                    Card(index: 16)
                }
            }
        }
    }
}

struct Rare: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("RARE")
                .font(
                    .system(
                        size: 30,
                        weight: .heavy
                    )
                )
                .foregroundColor(.black)
            
            // Cards
            VStack(spacing: 30) {
                HStack(spacing: 30) {
                    Card(index: 15)
                    Card(index: 14)
                    Card(index: 13)
                }
                HStack(spacing: 30) {
                    Card(index: 12)
                    Card(index: 11)
                    Card(index: 10)
                }
                HStack(spacing: 30) {
                    Card(index: 9)
                    Card(index: 8)
                    Card(index: 7)
                }
            }
        }
    }
}

struct Legendary: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("LEGENDARY")
                .font(
                    .system(
                        size: 30,
                        weight: .heavy
                    )
                )
                .foregroundColor(.black)
            
            // Cards
            VStack(spacing: 30) {
                HStack(spacing: 30) {
                    Card(index: 6)
                    Card(index: 5)
                    Card(index: 4)
                }
                HStack(spacing: 30) {
                    Card(index: 3)
                    Card(index: 2)
                    Card(index: 1)
                }
            }
        }
    }
}

struct CollectionView: View {
    @EnvironmentObject var util: Util
    @State private var isRotating = 0.0
    
    func format_collected() -> String {
        var count = 0
        
        for i in 1...util.collection_size {
            if util.collected[i] != nil && util.collected[i]! {
                count = count + 1
            }
        }
        
        if String(count).count == 1 { return "0" + String(count) + "/" + String(util.collection_size) }
        if String(count).count > 1 { return String(count) + "/" + String(util.collection_size) }
            
        return "ERR"
    }
    
    var body: some View {
        ZStack {
            Image("forest_purp1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                // Collected stats
                HStack {
                    Image("collected")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .foregroundColor(.black)
                    Text(format_collected())
                        .font(
                            .system(
                                size: 28,
                                weight: .heavy
                            )
                        )
                        .foregroundColor(.black)
                }
                .frame(
                    maxHeight: 33
                )

                ScrollView(showsIndicators: false) {
                    Common()
                    Spacer()
                        .frame(
                            minHeight: 70
                        )
                    Rare()
                    Spacer()
                        .frame(
                            minHeight: 70
                        )
                    Legendary()
                    Spacer()
                        .frame(
                            minHeight: 120
                        )
                }
                .padding(.top, 40)
            }
            .padding(20.0)
            .padding(.top, 50.0)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height,
                alignment: .topTrailing
            )
            
            // Showing card
            if (util.showing_card) {
                ZStack {
                    Image("godrays")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: UIScreen.main.bounds.width * 2
                        )
                        .rotationEffect(.degrees(isRotating))
                        .onAppear {
                            isRotating = 0.0
                            withAnimation(.linear(duration: 5.0).speed(0.1).repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                            }
                        }
                    
                    Image(calculate_index(index: util.showing_card_index))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: UIScreen.main.bounds.width * 0.7
                        )
                }
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
                .background(.black.opacity(0.7))
                .onTapGesture {
                    util.showing_card = false
                    util.showing_card_index = 0
                }
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView().environmentObject(Util())
    }
}
