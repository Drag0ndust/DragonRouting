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
    private var routes: Set<Route> = []

    public init(window: UIWindow? = nil) {
        self.window = window
    }
}

// MARK: - Configure
public extension AppRouter {
    func set(window: UIWindow?) {
        self.window = window
    }

    func add(_ route: Route) {
        routes.insert(route)
    }

    func remove(_ route: Route) {
        routes.remove(route)
    }

    private func route(for path: String) -> Route? {
        routes.first { $0.path == path}
    }
}

// MARK: - Public methods - Navigation
extension AppRouter {
    public func route(to path: String, with navigationType: NavigationType) {
        guard let route = route(for: path) else { return }
        let view = route.content()
        switch navigationType {
        case .modal:
            modal(view)
        case .push:
            push(view)
        }
    }

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

    public func dismiss(animated: Bool = true) {
        navigationController?.dismiss(animated: animated)
    }
}

// MARK: - Private methods
private extension AppRouter {
    func hostingController<Content: View>(_ view: Content) -> UIHostingController<Content> {
        UIHostingController(rootView: view)
    }
}
