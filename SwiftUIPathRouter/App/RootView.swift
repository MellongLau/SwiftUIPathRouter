//
//  RootView.swift
//  SwiftUIPathRouter
//
//  Created by mellong on 2024/7/2.
//

import SwiftUI

// sourcery: route
struct RootView: View {
    @ObservedObject var router: Router
    
    var body: some View {
        List {
            NavigationLink(route: .login, router: router) {
                Text("Navigation link")
            }
            NavigationLink(urlString: "/push/about", router: router) {
                Text("Navigation link with url string")
            }
            
            Button {
                router.navigateTo(.about)
            } label: {
                Text("Push with button event")
            }
            Button {
                router.navigateTo(.parameter(username: "Johnny"))
            } label: {
                Text("Push with parameter")
            }
            Button {
                router.presentFullScreen(.login)
            } label: {
                Text("Full screen cover")
            }
            
            Button {
                router.presentSheet(.login)
            } label: {
                Text("Sheet")
            }
            

        }
        .navigationTitle("SwiftUI Path Router Example")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RootView(router: Router(isPresented: .constant(.root)))
}


extension NavigationLink where Destination == Never {

    init(route: Router.Route, router: Router, @ViewBuilder label: () -> Label) {
        router.views.append(route)
        self.init(value: route, label: label)
    }
    
    init(urlString: String, router: Router, parameters: [String: Any]? = nil, @ViewBuilder label: () -> Label) {
        guard let result = Router.getRoute(urlString: urlString, parameters: parameters),
                let route = result.0 else {
            self.init(route: Router.Route.root, router: router, label: label)
            return
        }
        self.init(route: route, router: router, label: label)
    }
}
