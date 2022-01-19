//
//  OffGameViewController.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import ModernRIBs
import UIKit
import SnapKit


protocol OffGamePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func startGame()
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    
    var uiviewController: UIViewController {
        return self
    }

    weak var listener: OffGamePresentableListener?
    
    init(player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("메소드가 지원되지 않습니다.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellow
        buildStartButton()
        buildPlayerLabels()
    }
    
    // MARK: - Private
    
    private func buildStartButton() {
        let startButton = UIButton()
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
            make.leading.trailing.equalTo(self.view).inset(40)
            make.height.equalTo(100)
        }
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.black
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    @objc private func didTapStartButton() {
        listener?.startGame()
    }
    
    private func buildPlayerLabels() {
           let labelBuilder: (UIColor, String) -> UILabel = { (color: UIColor, text: String) in
               let label = UILabel()
               label.font = UIFont.boldSystemFont(ofSize: 35)
               label.backgroundColor = UIColor.clear
               label.textColor = color
               label.textAlignment = .center
               label.text = text
               return label
           }
        let player1Label = labelBuilder(UIColor.blue, player1Name)
        view.addSubview(player1Label)
        player1Label.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(70)
            maker.leading.trailing.equalTo(self.view).inset(20)
            maker.height.equalTo(40)
        }
        
        let vsLabel = UILabel()
        vsLabel.font = UIFont.systemFont(ofSize: 25)
        vsLabel.backgroundColor = UIColor.clear
        vsLabel.textColor = UIColor.darkGray
        vsLabel.textAlignment = .center
        vsLabel.text = "vs"
        view.addSubview(vsLabel)
        vsLabel.snp.makeConstraints { make in
            make.top.equalTo(player1Label.snp.bottom).offset(10)
            make.leading.trailing.equalTo(player1Label)
            make.height.equalTo(20)
        }
        
        let player2Label = labelBuilder(UIColor.red, player2Name)
        view.addSubview(player2Label)
        player2Label.snp.makeConstraints { make in
            make.top.equalTo(vsLabel.snp.bottom).offset(10)
            make.height.leading.trailing.equalTo(player1Label)
        }
    }
    private let player1Name: String
    private let player2Name: String
}
