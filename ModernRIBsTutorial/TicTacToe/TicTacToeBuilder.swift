//
//  TicTacToeBuilder.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/15.
//

import ModernRIBs

protocol TicTacToeDependency: Dependency {
    var player1Name: String { get }
    var player2Name: String { get }
    var mutableScoreStream: MutableScoreStream { get }
}

final class TicTacToeComponent: Component<TicTacToeDependency> {

    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }

    fileprivate var mutableScoreStream: MutableScoreStream {
        return dependency.mutableScoreStream
    }
}

// MARK: - Builder

protocol TicTacToeBuildable: Buildable {
    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting
}

final class TicTacToeBuilder: Builder<TicTacToeDependency>, TicTacToeBuildable {

    override init(dependency: TicTacToeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting {
        let component = TicTacToeComponent(dependency: dependency)
        let viewController = TicTacToeViewController(player1Name: component.player1Name,
                                                     player2Name: component.player2Name)
        let interactor = TicTacToeInteractor(presenter: viewController,
                                             mutableScoreStream: component.mutableScoreStream)
        interactor.listener = listener
        return TicTacToeRouter(interactor: interactor, viewController: viewController)
    }
}
