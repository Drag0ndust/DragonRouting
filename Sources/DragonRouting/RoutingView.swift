//
//  WindowFetcher.swift
//  DragonRouting
//
//  Created by Thimo Bess on 18.05.22.
//

import SwiftUI
import UIKit

/// Fetch the main window of the current app, so it can be used in the SwiftUI context
public struct RoutingView<Content: View>: View {
    private let router: AppRouter
    private var content: (UIWindow?) -> Content
    private var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            router.set(window: nil)
            return nil
        }
        router.set(window: window)
        return window
    }

    public init(_ router: AppRouter, content: @escaping (UIWindow?) -> Content) {
        self.router = router
        self.content = content
    }

    public var body: some View {
        NavigationView {
            content(window)
                .environmentObject(router)
        }
    }
}

#if DEBUG
struct WindowFetcher_Previews: PreviewProvider {
    static var previews: some View {
        RoutingView(AppRouter()) { window in
            Text("Preview")
        }
    }
}
#endif
