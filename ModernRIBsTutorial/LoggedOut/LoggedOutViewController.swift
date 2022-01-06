//
//  LoggedOutViewController.swift
//  TicTacToe
//
//  Created by BH on 2022/01/06.
//  Copyright © 2022 Uber. All rights reserved.
//

import ModernRIBs
import SnapKit
import UIKit

protocol LoggedOutPresentableListener: class {
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let playerFields = buildPayerFields()
        buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
    }
    
//    MARK: Private
    
    private var player1Field: UITextField?
    private var player2Field: UITextField?
    
    private func buildPayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        
        let player1Field = UITextField()
        
        self.player1Field = player1Field
        player1Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player1Field)
        player1Field.placeholder = " Player 1 name"
        player1Field.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self.view).offset(100)
            make.leading.trailing.equalTo(self.view).inset(40)
            make.height.equalTo(40)
        }
        
        let player2Field = UITextField()
        
        self.player2Field = player2Field
        player2Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player2Field)
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(player1Field.snp.bottom).offset(20)
            make.left.right.height.equalTo(player1Field)
        }
        return (player1Field, player2Field)
    }

    private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
    let loginButton = UIButton()
    view?.addSubview(loginButton)
    loginButton.snp.makeConstraints { make in
        make.top.equalTo(player2Field.snp.bottom).offset(20)
        make.left.right.height.equalTo(player1Field)

    }
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.black
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
}

 @objc private func didTapLoginButton() {
     listener?.login(withPlayer1Name: player1Field?.text, player2Name: player2Field?.text)
 }
}

// 전처리
#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
        LoggedOutViewController()
    }
}

struct ViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        ViewControllerRepresentable()

// 테스트 해보고자 하는 기기
            .previewDevice("iPhone 11")
    }
}
#endif
