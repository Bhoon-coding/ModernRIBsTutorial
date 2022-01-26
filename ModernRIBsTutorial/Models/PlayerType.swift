//
//  PlayerType.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import UIKit

public enum PlayerType: Int {
    case player1 = 1
    case player2
    
    var color: UIColor {
        switch self {
        case .player1:
            return UIColor.red
        case .player2:
            return UIColor.blue
        }
    }
}
