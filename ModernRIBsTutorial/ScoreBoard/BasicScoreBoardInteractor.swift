//
//  BasicScoreBoardInteractor.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import ModernRIBs
import RxSwift

public protocol BasicScoreBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BasicScoreBoardPresentable: Presentable {
    var listener: BasicScoreBoardPresentableListener? { get set }
    func set(score: Score)
}

public protocol BasicScoreBoardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BasicScoreBoardInteractor: PresentableInteractor<BasicScoreBoardPresentable>, BasicScoreBoardInteractable, BasicScoreBoardPresentableListener {

    weak var router: BasicScoreBoardRouting?

    weak var listener: BasicScoreBoardListener?

    init(presenter: BasicScoreBoardPresentable,
         scoreStream: ScoreStream) {
        self.scoreStream = scoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        updateScore()
    }

    // MARK: - Private

    private let scoreStream: ScoreStream

    private func updateScore() {
        scoreStream.score
            .subscribe(onNext: { (score: Score) in
                self.presenter.set(score: score)
            })
            .disposeOnDeactivate(interactor: self)
    }
}
