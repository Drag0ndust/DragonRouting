//
//  Route.swift
//  DragonRouting
//
//  Created by Thimo Bess on 19.05.22.
//

import SwiftUI

public protocol Route {
    var path: String { get }
    var content: () -> AnyView { get }
}
