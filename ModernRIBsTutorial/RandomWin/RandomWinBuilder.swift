//
//  RandomWinBuilder.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import ModernRIBs

public protocol RandomWinDependency: Dependency {
    var player1Name: String { get }
    var player2Name: String { get }
    var mutableScoreStream: MutableScoreStream { get }
}

final class RandomWinComponent: Component<RandomWinDependency> {

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

protocol RandomWinBuildable: Buildable {
    func build(withListener listener: RandomWinListener) -> RandomWinRouting
}

public final class RandomWinBuilder: Builder<RandomWinDependency>, RandomWinBuildable {

    public override init(dependency: RandomWinDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: RandomWinListener) -> RandomWinRouting {
        let component = RandomWinComponent(dependency: dependency)
        let viewController = RandomWinViewController(player1Name: component.player1Name,
                                                     player2Name: component.player2Name)
        let interactor = RandomWinInteractor(presenter: viewController,
                                             mutableScoreStream: component.mutableScoreStream)
        interactor.listener = listener
        return RandomWinRouter(interactor: interactor, viewController: viewController)
    }
}
