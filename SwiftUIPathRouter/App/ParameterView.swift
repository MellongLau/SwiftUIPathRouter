//
//  ParameterView.swift
//  SwiftUIPathRouter
//
//  Created by mellong on 2024/7/2.
//

import SwiftUI

// sourcery: route
struct ParameterView: View {
    @ObservedObject var router: Router
    // sourcery: parameterized
    var username: String
    
    var body: some View {
        Text("Hello, \(username)")
    }
}

#Preview {
    ParameterView(router:
                    Router(isPresented: .constant(.parameter(username: "Johnny"))), username: "Johnny"
    )
}
