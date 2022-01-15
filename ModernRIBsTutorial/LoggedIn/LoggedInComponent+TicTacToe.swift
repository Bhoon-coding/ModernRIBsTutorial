//
//  LoggedInComponent+OffGame.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/15.
//

import ModernRIBs

protocol LoggedInDependencyTicTacToe: Dependency {

    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the TicTacToe scope.
}

extension LoggedInComponent: TicTacToeDependency {

    // TODO: Implement properties to provide for TicTacToe scope.
}
