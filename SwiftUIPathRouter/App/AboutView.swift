//
//  AboutView.swift
//  SwiftUIPathRouter
//
//  Created by mellong on 2024/7/2.
//

import SwiftUI

// sourcery: route
struct AboutView: View {
    @ObservedObject var router: Router
    
    var body: some View {
        Text("About page")
    }
}

#Preview {
    AboutView(router: Router(isPresented: .constant(.about)))
}
