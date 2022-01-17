//
//  RootBuilder.swift
//  ModernRIBsTutorial
//
//  Created by Ppop on 2021/12/28.
//

import ModernRIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    let rootViewController: RootViewController
//
    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>,
                            RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

//  객체전달을 위해  build 메소드에 새로생긴RIB의 Builder 객체를 생성해서 주입할수 있도록 하기
//  객체 생성했으면 RootRouter로 이동
    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency,
                                      rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)

        // 객체 생성 부분
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        let loggedInBuilder = LoggedInBuilder(dependency: component)
        // 객체 전달 부분
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          loggedOutBuilder: loggedOutBuilder,
                          loggedInBuilder: loggedInBuilder)
    }
}
