//
//  File.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/25.
//

import RxSwift

public protocol LoggedInActionableItem: AnyObject {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())>
}
