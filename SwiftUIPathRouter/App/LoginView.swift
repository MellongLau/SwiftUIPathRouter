//
//  LoginView.swift
//  SwiftUIPathRouter
//
//  Created by mellong on 2024/7/2.
//

import SwiftUI

// sourcery: route
struct LoginView: View {
    @ObservedObject var router: Router
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login page")
            Button {
                router.dismiss()
            } label: {
                Text("Close")
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            }
        }

    }
}



#Preview {
    LoginView(router: Router(isPresented: .constant(.login)))
}
