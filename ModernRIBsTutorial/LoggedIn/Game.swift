//
//  Game.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import ModernRIBs

public protocol GameListener: AnyObject {
    func gameDidEnd(with winner: PlayerType?)
}

public protocol GameBuildable: Buildable {
    func build(withListener listener: GameListener) -> ViewableRouting
}

public protocol Game {
    var id: String { get }
    var name: String { get }
    var builder: GameBuildable { get }
}

