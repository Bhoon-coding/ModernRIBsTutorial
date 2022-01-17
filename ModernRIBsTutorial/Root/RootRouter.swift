//
//  RootRouter.swift
//  ModernRIBsTutorial
//
//  Created by Ppop on 2021/12/28.
//

import ModernRIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable) 
}

// RootRouter가 새로만든 RIB을 attach 하기 위해서 해당 RIB을 구성하는 컴포넌트들을 생성하는 Builder를 갖고 있어야함.

// RIB이 새로 생길시 부모Router에서 할일
// - private 상수 생성된RIB빌더 선언
//     ex) private let loggedOutBuilder: LoggedOutBuildable
// - RootRouter init에서 (새로생긴RIBBuildable)프로토콜 전달받을 수 있게 수정.
//     ex) init(loggedInBuilder: LoggedInBuildable) { self.loggedInBuilder = loggedInbuilder }
// 객체 전달을 위해 RootBuilder의 build 메소드로 이동

// 객체 전달을 받은 후 (build 메소드 수정 후)

//  (detach) LoggedOut RIB,  (attach) LoggedIn RIB - routeToLoggedIn 함수 구현
            
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
    
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }
    
    // MARK: RootRouting
    
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String) {
        // Detach LoggedOut RIB.
        if let loggedOut = self.loggedOut {
            detachChild(loggedOut)
            viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }
      
        let loggedIn = loggedInBuilder.build(withListener: interactor)
        attachChild(loggedIn)
    }

    
    // MARK: - Private
    
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedInBuilder: LoggedInBuildable
    
    private var loggedOut: ViewableRouting?
    }
