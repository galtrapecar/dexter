//
//  RootView.swift
//  dexter
//
//  Created by Dev on 31/12/2022.
//

import SwiftUI
import TabBar

enum Item: Int, Tabbable {
    case first = 0
    case second
    case third
    case fourth
    case fifth
    
    var icon: String {
        switch self {
            case .first:  return "house.fill"
            case .second: return "calendar"
            case .third:  return "line.3.horizontal"
            case .fourth: return "rectangle.grid.3x2"
            case .fifth:  return "gearshape.fill"
        }
    }
    
    var title: String {
        switch self {
            case .first:  return "Home"
            case .second: return "Calendar"
            case .third:  return ""
            case .fourth: return "Collection"
            case .fifth:  return "Settings"
        }
    }
}

struct CustomTabBarStyle: TabBarStyle {
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0)
                .fill(.ultraThinMaterial)
                .frame(height: 100.0, alignment: .topTrailing)
                .overlay(
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(.white, lineWidth: 0.4)
                )
            itemsContainer()
                .frame(height: 100.0, alignment: .topTrailing)
                .background(Color.white.opacity(0.0))
                .padding(.horizontal, 10.0)
        }
    }
    
}

struct CustomTabItemStyle: TabItemStyle {
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        ZStack {
            if (title == "") {
                RoundedRectangle(cornerRadius: 999.0)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .stroke(.white, lineWidth: 0.4)
                    )
                    .frame(
                        width: 60.0,
                        height: 60.0
                    )
            }
            Image(systemName: icon)
                .resizable()
                .foregroundColor(isSelected ? .white : Color.black.opacity(0.8))
                .scaledToFit()
                .frame(width: title == "" ? 28.0 : 24.0, height: title == "" ? 30.0 : 24.0)
        }
        .offset(y: title == "" ? -30.0 : 0.0)
        .padding(.vertical, 8.0)
    }
}

struct RootView: View {
    @EnvironmentObject var util: Util
    @State private var selection: Item = .first
    @State private var visibility: TabBarVisibility = .visible
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    var body: some View {
        switch util.page {
        case .login:
            LoginView()
        case .home:
            TabBar(selection: $selection, visibility: $visibility) {
                HomeView()
                    .tabItem(for: Item.first)
                
                CalendarView()
                    .tabItem(for: Item.second)
                
                MenuView()
                    .tabItem(for: Item.third)
                
                CollectionView()
                    .tabItem(for: Item.fourth)
                
                SettingsView()
                    .tabItem(for: Item.fifth)
            }
            .tabBar(style: CustomTabBarStyle())
            .tabItem(style: CustomTabItemStyle())
        case .subject:
            SubjectView()
        case .chest:
            ChestView()
        case _:
            VStack {
                Text("Error")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(Util())
    }
}
