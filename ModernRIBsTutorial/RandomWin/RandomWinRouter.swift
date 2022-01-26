//
//  RandomWinRouter.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import ModernRIBs

protocol RandomWinInteractable: Interactable {
    var router: RandomWinRouting? { get set }
    var listener: RandomWinListener? { get set }
}

protocol RandomWinViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RandomWinRouter: ViewableRouter<RandomWinInteractable, RandomWinViewControllable>, RandomWinRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RandomWinInteractable, viewController: RandomWinViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
