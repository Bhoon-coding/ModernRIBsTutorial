//
//  LoggedInInteractor.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import ModernRIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToOffGame(with games: [Game])
    func routeToGame(with gameBuilder: GameBuildable)
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(games: [Game]) {
        self.games = games
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        router?.routeToOffGame(with: games)
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }

    // MARK: - OffGameListener

    func startGame(with gameBuilder: GameBuildable) {
        router?.routeToGame(with: gameBuilder)
    }

    // MARK: - TicTacToeListener

    func gameDidEnd(with winner: PlayerType?) {
        router?.routeToOffGame(with: games)
    }

    // MARK: - Private

    private var games = [Game]()

}
