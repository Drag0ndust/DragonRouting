//
//  Router.swift
//  DragonRouting
//
//  Created by Thimo Bess on 18.05.22.
//

import Foundation
import UIKit
import SwiftUI

public class AppRouter: ObservableObject {
    private var window: UIWindow?
    private var navigationController: UINavigationController? {
        window?.rootViewController?.findNestedUINavigationController()
    }
    private var routes: [Route] = []

    public init(window: UIWindow? = nil) {
        self.window = window
    }
}

// MARK: - Configure
public extension AppRouter {
    func set(window: UIWindow?) {
        self.window = window
    }

//    func register(_ route: Route) {
//        routes.append(route)
//    }
//
//    func remove(_ route: Route) {
//        guard let index = routes.firstIndex(where: { $0.path == route.path }) else { return }
//        routes.remove(at: index)
//    }

    func route(for path: String) -> Route? {
        routes.first { $0.path == path}
    }
}

// MARK: - Public methods - Navigation
extension AppRouter {
//    public func present(route: Route, with type: NavigationType) {
//        switch type {
//        case .modal:
//            modal(route.content())
//        case .push:
//            push(route.content())
//        }
//    }

//    public func present(path: String, with type: NavigationType) {
//        guard let route = route(for: path) else { return }
//
//        switch type {
//        case .modal:
//            modal(route.content().environmentObject(self))
//        case .push:
//            push(route.content().environmentObject(self))
//        }
//    }
    
    public func modal<Content: View>(_ view: Content, animated: Bool = true) {
        let navView = NavigationView { view.environmentObject(self) }
        let controller = hostingController(navView)
        navigationController?.present(controller, animated: animated)
    }

    public func push<Content: View>(_ view: Content, animated: Bool = true) {
        navigationController?.pushViewController(hostingController(view.environmentObject(self)), animated: animated)
    }

    public func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    public func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }

    public func dismissModal(animated: Bool = true) {
        navigationController?.dismiss(animated: animated)
    }
}

// MARK: - Private methods
private extension AppRouter {
    func hostingController<Content: View>(_ view: Content) -> UIHostingController<Content> {
        UIHostingController(rootView: view)
    }
}
