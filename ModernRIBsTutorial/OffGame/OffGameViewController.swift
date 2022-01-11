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
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    
    var uiviewController: UIViewController {
        return self
    }

    weak var listener: OffGamePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("메소드가 지원되지 않습니다.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellow
        buildStartButton()
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
    }
}
