//
//  RoutingFactoryTests.swift
//  
//
//  Created by Thimo Bess on 19.04.22.
//

import XCTest
@testable import DragonRouting

class RoutingFactoryTests: XCTestCase {
    private var sut: RoutingFactory!

    override func setUpWithError() throws {
        sut = RoutingFactory()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Instantiate() throws {
        XCTAssertNotNil(sut)
    }

    func test_can_register_route() throws {
        let route = TestRoute.dashboard
        let view = Text("TestView")

//        sut.register(route, view: view)
    }
}





// MARK: - Move later

import SwiftUI
enum TestRoute: Route {
    case dashboard
}

//
//
//class TestRouter: Routing {
//    typealias Route = TestRoute
//
//    func view(for route: TestRoute) -> some View {
//        return EmptyView()
//    }
//}
