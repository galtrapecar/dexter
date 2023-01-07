//
//  Util.swift
//  dexter
//
//  Created by Dev on 31/12/2022.
//

import SwiftUI

struct Theme {
    static let yellow =     Color("yellow")
    static let dark_gray =  Color("dark_gray")
    static let art =        Color("art")
    static let biology =    Color("biology")
    static let chemistry =  Color("chemistry")
    static let english =    Color("english")
    static let geography =  Color("geography")
    static let history =    Color("history")
    static let math =       Color("math")
    static let music =      Color("music")
    static let pe =         Color("pe")
    static let physics =    Color("physics")
    static let spanish =    Color("spanish")
}

struct FlatGlassView : ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.white)
                            .opacity(0.4)
                    )
                .background(.ultraThinMaterial)
        } else {
            content
        }
    }
}

class Util: ObservableObject {
    public enum Page {
        case login
        case home
        case calendar
        case collection
        case chest
        case settings
        case subject
    }
    
    @Published var page = Page.login
    @Published var points = 63.0;
    
    func set_page(_page: Page) {
        page = _page
    }
    
    func get_points() -> CGFloat {
        return points
    }
}
