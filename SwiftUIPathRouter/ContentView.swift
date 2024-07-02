//
//  ContentView.swift
//  SwiftUIPathRouter
//
//  Created by mellong on 2024/7/2.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router: Router = Router(isPresented: .constant(.root))
    
    var body: some View {
        RouterView(router: router) {
            NavigationView {
                RootView(router: router)
                
            }
            .navigationViewStyle(.stack)
        }
    }
}

#Preview {
    ContentView()
}
