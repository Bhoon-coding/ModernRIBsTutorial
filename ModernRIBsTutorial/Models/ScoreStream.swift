//
//  ScoreStream.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/26.
//

import RxSwift
import RxCocoa

public struct Score {
    public let player1Score: Int
    public let player2Score: Int

    public static func equals(lhs: Score, rhs: Score) -> Bool {
        return lhs.player1Score == rhs.player1Score && lhs.player2Score == rhs.player2Score
    }
}

public protocol ScoreStream: AnyObject {
    var score: Observable<Score> { get }
}

public protocol MutableScoreStream: ScoreStream {
    func updateScore(with winner: PlayerType)
}

public class ScoreStreamImpl: MutableScoreStream {

    public init() {}

    public var score: Observable<Score> {
        return variable
            .asObservable()
            .distinctUntilChanged { (lhs: Score, rhs: Score) -> Bool in
                Score.equals(lhs: lhs, rhs: rhs)
            }
    }

    public func updateScore(with winner: PlayerType) {
        let newScore: Score = {
            let currentScore = variable.value
            switch winner {
            case .player1:
                return Score(player1Score: currentScore.player1Score + 1, player2Score: currentScore.player2Score)
            case .player2:
                return Score(player1Score: currentScore.player1Score, player2Score: currentScore.player2Score + 1)
            }
        }()
        variable.accept(newScore)
    }

    // MARK: - Private

    private let variable = BehaviorRelay<Score>(value: Score(player1Score: 0, player2Score: 0))
}
