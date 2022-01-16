//
//  LoggedOutInteractor.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/06.
//  Copyright © 2022 Uber. All rights reserved.
//

import ModernRIBs

protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedOutListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    // 상향 통신을 할때 Listener 인터페이스 사용 (LoggedOut RIB -> Root RIB 통신)
    func didLogin(withPlayer1Name player1Name: String, player2Name: String) 
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedOutPresentable) {
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
    
    func login(withPlayer1Name player1Name: String?, player2Name: String?) {
        
        let player1NameWithDefault = playerName(player1Name, withDefaultName: "Player 1")
        let player2NameWithDefault = playerName(player2Name, withDefaultName: "Player 2")
        listener?.didLogin(withPlayer1Name: player1NameWithDefault, player2Name: player2NameWithDefault)
            print("\(player1NameWithDefault) vs \(player2NameWithDefault)")
    }
    
    private func playerName(_ name: String?, withDefaultName defaultName: String) -> String {
        if let name = name {
            return name.isEmpty ? defaultName : name
        } else {
            return defaultName
        }
    }
}
