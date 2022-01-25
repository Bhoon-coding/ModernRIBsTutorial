//
//  RootActionableItem.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/25.
//

import RxSwift

public protocol RootActionableItem: AnyObject {
    func waitForLogin() -> Observable<(LoggedInActionableItem, ())>
}
