//
//  OffGameBuilder.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import ModernRIBs


public protocol OffGameDependency: Dependency {
    var player1Name: String { get }
    var player2Name: String { get }
    var scoreStream: ScoreStream { get }
}

final class OffGameComponent: Component<OffGameDependency>, BasicScoreBoardDependency {

    var player1Name: String {
        return dependency.player1Name
    }

    var player2Name: String {
        return dependency.player2Name
    }

    var scoreStream: ScoreStream {
        return dependency.scoreStream
    }
}

// MARK: - Builder

protocol OffGameBuildable: Buildable {
    func build(withListener listener: OffGameListener, games: [Game]) -> OffGameRouting
}

final class OffGameBuilder: Builder<OffGameDependency>, OffGameBuildable {

    override init(dependency: OffGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OffGameListener, games: [Game]) -> OffGameRouting {
        let component = OffGameComponent(dependency: dependency)
        let viewController = OffGameViewController(games: games)
        let interactor = OffGameInteractor(presenter: viewController)
        interactor.listener = listener

        let scoreBoardBuilder = BasicScoreBoardBuilder(dependency: component)
        let router = OffGameRouter(interactor: interactor,
                                   viewController: viewController,
                                   scoreBoardBuilder: scoreBoardBuilder)
        return router
    }
}
