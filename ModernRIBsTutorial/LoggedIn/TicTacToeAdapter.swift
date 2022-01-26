//
//  TicTacToeAdapter.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import ModernRIBs

class TicTacToeAdapter: Game, GameBuildable, TicTacToeListener {
    let id = "tictactoe"
    let name = "Tic Tac Toe"
    let ticTacToeBuilder: TicTacToeBuilder
    var builder: GameBuildable {
        return self
    }

    weak var gameListener: GameListener?

    init(dependency: TicTacToeDependency) {
        ticTacToeBuilder = TicTacToeBuilder(dependency: dependency)
    }

    func build(withListener listener: GameListener) -> ViewableRouting {
        gameListener = listener
        return ticTacToeBuilder.build(withListener: self)
    }

    func ticTacToeDidEnd(with winner: PlayerType?) {
        gameListener?.gameDidEnd(with: winner)
    }
}

