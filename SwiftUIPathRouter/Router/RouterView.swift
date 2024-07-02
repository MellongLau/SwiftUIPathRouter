//
//  RouterView.swift
//
//  Created by mellong on 2024/3/25.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router
    private let content: Content
    
    init(router: Router, @ViewBuilder content: @escaping () -> Content) {
        _router = StateObject(wrappedValue: router)
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) { route in
                    router.view(for: route, type: .push)
                }
        }
        .sheet(item: $router.presentingSheet) { route in
            router.view(for: route, type: .sheet)
        }
        .fullScreenCover(item: $router.presentingFullScreenCover) { route in
            router.view(for: route, type: .fullScreenCover)
        }
    }
}
