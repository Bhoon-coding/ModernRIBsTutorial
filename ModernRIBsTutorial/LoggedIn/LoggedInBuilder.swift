//
//  LoggedInBuilder.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import ModernRIBs

protocol LoggedInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var loggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency>, OffGameDependency {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var loggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency)
        let interactor = LoggedInInteractor()
        interactor.listener = listener
        
        let offGameBuilder = OffGameBuilder(dependency: component)
        return LoggedInRouter(interactor: interactor,
                              viewController: component.loggedInViewController,
                              offGameBuilder: offGameBuilder)
    }
}
