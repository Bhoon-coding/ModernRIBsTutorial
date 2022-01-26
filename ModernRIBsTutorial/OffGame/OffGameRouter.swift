//
//  OffGameRouter.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import ModernRIBs

protocol OffGameInteractable: Interactable, BasicScoreBoardListener {
    var router: OffGameRouting? { get set }
    var listener: OffGameListener? { get set }
}

protocol OffGameViewControllable: ViewControllable {
    func show(scoreBoardView: ViewControllable)
}

final class OffGameRouter: ViewableRouter<OffGameInteractable, OffGameViewControllable>, OffGameRouting {

    init(interactor: OffGameInteractable,
         viewController: OffGameViewControllable,
         scoreBoardBuilder: BasicScoreBoardBuildable) {
        self.scoreBoardBuilder = scoreBoardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()

        attachScoreBoard()
    }

    // MARK: - Private

    private var scoreBoardBuilder: BasicScoreBoardBuildable

    private func attachScoreBoard() {
        let scoreBoard = scoreBoardBuilder.build(withListener: interactor)
        attachChild(scoreBoard)
        viewController.show(scoreBoardView: scoreBoard.viewControllable)
    }
}
