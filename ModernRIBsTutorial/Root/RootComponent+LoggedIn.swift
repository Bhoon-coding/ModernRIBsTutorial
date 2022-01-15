//
//  RootComponent+LoggedOut.swift
//  ModernRIBsTutorial
//
//  Created by Ppop on 2021/12/28.
//

import ModernRIBs


protocol RootDependencyLoggedIn: Dependency {

    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedIn scope.
}

extension RootComponent: LoggedInDependency {

    // TODO: Implement properties to provide for LoggedOut scope.
    var loggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
}
