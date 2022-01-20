//
//  OffGameInteractor.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import ModernRIBs

protocol OffGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }
    func set(score: Score)
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OffGameListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didStartGame()
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {

    weak var router: OffGameRouting?
    weak var listener: OffGameListener?
    
    private let scoreStream: ScoreStream

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
    
    func startGame() {
        listener?.didStartGame()
    }
    
    
    
}
