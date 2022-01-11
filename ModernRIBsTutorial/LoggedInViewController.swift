//
//  LoggedInViewController.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/11.
//

import RIBs
import RxSwift
import UIKit

protocol LoggedInPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class LoggedInViewController: UIViewController, LoggedInPresentable, LoggedInViewControllable {

    weak var listener: LoggedInPresentableListener?
}
