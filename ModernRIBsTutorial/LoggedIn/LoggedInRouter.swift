//
//  LoggedInRouter.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import ModernRIBs

protocol LoggedInInteractable: Interactable, OffGameListener, GameListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable?)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    // MARK: - LoggedInRouting

    func cleanupViews() {
        if currentChild != nil {
            viewController.replaceModal(viewController: nil)
        }
    }

    func routeToOffGame(with games: [Game]) {
        detachCurrentChild()
        attachOffGame(with: games)
    }

    func routeToGame(with gameBuilder: GameBuildable) {
        detachCurrentChild()

        let game = gameBuilder.build(withListener: interactor)
        self.currentChild = game
        attachChild(game)
        viewController.replaceModal(viewController: game.viewControllable)
    }

    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable

    private var currentChild: ViewableRouting?

    private func attachOffGame(with games: [Game]) {
        let offGame = offGameBuilder.build(withListener: interactor, games: games)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.replaceModal(viewController: offGame.viewControllable)
    }

    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.replaceModal(viewController: nil)
        }
    }
}
