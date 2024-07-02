//
//  Router.swift
//
//  Created by mellong on 2024/3/25.
//

import SwiftUI


class Router: ObservableObject {
    
    enum NavigationType: String {
        case push
        case sheet
        case fullScreenCover
        case action
    }
    
    // Used to programatically control our navigation stack
    @Published var path: NavigationPath = NavigationPath()
    // Used to present a view using a sheet
    @Published var presentingSheet: Route?
    // Used to present a view using a full screen cover
    @Published var presentingFullScreenCover: Route?
    // Used for presented Router instances to dissmiss
    @Published var isPresented: Binding<Route?>
    var views: [Route] = []
    
    init(isPresented: Binding<Route?>) {
        self.isPresented = isPresented
    }
    
    // Used by views to navigate to another view
    func navigateTo(_ appRoute: Route, animated: Bool = true) {
        views.append(appRoute)
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            path.append(appRoute)
        }
    }
    
    func setRoutes(_ routes: [Route], animated: Bool = true) {
        views = routes
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            path = NavigationPath(views)
        }
        
    }
    
    func removeRoute(_ route: Route) {
        if views.contains(where: { $0 == route }) {
            views = views.filter({ $0 != route })
            path = NavigationPath(views)
        }
    }
    
    // Used to go back to the previous screen
    func navigateBack(animated: Bool = true) {
        if !views.isEmpty {
            views.removeLast()
        }
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            path.removeLast()
        }
    }
    
    // Pop to the root screen in our hierarchy
    func popToRoot(animated: Bool = true) {
        views.removeAll()
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            path.removeLast(path.count)
            debugPrint(path.count)
        }
    }
    
    
    func popToRoute(route: Route, animated: Bool = true) {
        guard let index = views.firstIndex(of: route) else { return }
        let items = views.count - index - 1
        views.removeLast(items)
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            path.removeLast(path.count - index - 1)
        }
    }
    
    func router(navigationType: NavigationType) -> Router {
        switch navigationType {
        case .push:
            return self
        case .sheet:
            return Router(
                isPresented: Binding(
                    get: { self.presentingSheet },
                    set: { self.presentingSheet = $0 }
                )
            )
        case .fullScreenCover:
            return Router(
                isPresented: Binding(
                    get: { self.presentingFullScreenCover },
                    set: { self.presentingFullScreenCover = $0 }
                )
            )
        default:
            return self
        }
    }
    
    // Used to present a screen using a sheet
    func presentSheet(_ route: Route) {
        self.presentingSheet = route
    }
    
    // Used to present a screen using a full screen cover
    func presentFullScreen(_ route: Route) {
        self.presentingFullScreenCover = route
    }
    
    // Dismisses presented screen or self
    func dismiss() {
        if !path.isEmpty {
            path.removeLast()
        } else if presentingSheet != nil {
            presentingSheet = nil
        } else if presentingFullScreenCover != nil {
            presentingFullScreenCover = nil
        } else {
            isPresented.wrappedValue = nil
        }
    }
    
    // 新增解析路径字符串的方法 /push/chat
    func navigateTo(urlString: String, parameters: [String: Any]? = nil) {
        
        guard let result = Self.getRoute(urlString: urlString, parameters: parameters),
              let route = result.0,
              let navigationType = result.1 else { return }
        
        // 根据导航类型执行相应的导航操作
        switch navigationType {
        case .push:
            navigateTo(route)
        case .sheet:
            presentSheet(route)
        case .fullScreenCover:
            presentFullScreen(route)
        default:
            break
        }
    }
    
    func isRootView() -> Bool {
        path.count == 2
    }
    
    static func getRoute(urlString: String, parameters: [String: Any]? = nil) -> (Route?, NavigationType?)? {
        // 解析字符串并分割成组件
        let components = urlString.split(separator: "/").map { String($0) }
        
        // 确保至少有两个组件（导航类型和视图）
        guard components.count >= 2 else { return nil }
        
        // 第一个组件应该是导航类型
        let typeString = components[0]
        // 第二个组件应该是视图路径
        let routeString = components[1]
        
        // 尝试匹配导航类型和视图路径
        let navigationType = NavigationType(rawValue: typeString)
        let route = Route(rawValue: routeString, parameters: parameters)
        return (route, navigationType)
    }
    
    static func getActionType(urlString: String) -> String? {
        let components = urlString.split(separator: "/").map { String($0) }
        guard components.count > 1 else { return nil }
        return components[1]
    }
    
}
// 修改 Router 类，添加一个直接获取视图的方法
extension Router {
    @ViewBuilder func getView(for route: Route) -> some View {
        view(for: route, type: .push)
    }
}


