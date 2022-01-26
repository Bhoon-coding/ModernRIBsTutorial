//
//  BasicScoreBoardRouter.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import RIBs

protocol BasicScoreBoardInteractable: Interactable {
    var router: BasicScoreBoardRouting? { get set }
    var listener: BasicScoreBoardListener? { get set }
}

protocol BasicScoreBoardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BasicScoreBoardRouter: ViewableRouter<BasicScoreBoardInteractable, BasicScoreBoardViewControllable>, BasicScoreBoardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BasicScoreBoardInteractable, viewController: BasicScoreBoardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
