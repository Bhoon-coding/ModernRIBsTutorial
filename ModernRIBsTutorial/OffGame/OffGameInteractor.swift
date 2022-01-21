//
//  OffGameInteractor.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import ModernRIBs
import RxSwift
import Foundation

protocol OffGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }
    func set(score: Score)
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OffGameListener: AnyObject {
    func startTicTacToe()
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {

    weak var router: OffGameRouting?
    weak var listener: OffGameListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: OffGamePresentable,
                  scoreStream: ScoreStream) {
        self.scoreStream = scoreStream
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

    // MARK: - OffGamePresentableListener

    func startGame() {
        listener?.startTicTacToe()
    }
    
    private func updateScore() {
        scoreStream.score
            .subscribe(
                onNext: { ( score: Score) in
                    self.presenter.set(score: score)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private let scoreStream: ScoreStream
    private let disposeBag = DisposeBag()
}
