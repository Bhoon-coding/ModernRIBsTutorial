//
//  RandomWinInteractor.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import ModernRIBs
import RxSwift
import UIKit

public protocol RandomWinRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RandomWinPresentable: Presentable {
    var listener: RandomWinPresentableListener? { get set }
    func announce(winner: PlayerType, withCompletionHandler handler: @escaping () -> ())
}

public protocol RandomWinListener: AnyObject {
    func didRandomlyWin(with player: PlayerType)
}

final class RandomWinInteractor: PresentableInteractor<RandomWinPresentable>, RandomWinInteractable, RandomWinPresentableListener {

    weak var router: RandomWinRouting?

    weak var listener: RandomWinListener?

    init(presenter: RandomWinPresentable,
         mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - RandomWinPresentableListener

    func determineWinner() {
        let random = arc4random_uniform(100)
        let winner = random > 50 ? PlayerType.player1 : PlayerType.player2
        presenter.announce(winner: winner) {
            self.mutableScoreStream.updateScore(with: winner)
            self.listener?.didRandomlyWin(with: winner)
        }
    }

    // MARK: - Private

    private let mutableScoreStream: MutableScoreStream
}
