//
//  Route.swift
//  DragonRouting
//
//  Created by Thimo Bess on 19.05.22.
//

import SwiftUI

public struct Route {
    let path: String
    let content: () -> AnyView

    public init(path: String, @ViewBuilder content: @escaping () -> AnyView) {
        self.path = path
        self.content = content
    }
}

extension Route: Hashable {
    public static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.path == rhs.path
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
}
