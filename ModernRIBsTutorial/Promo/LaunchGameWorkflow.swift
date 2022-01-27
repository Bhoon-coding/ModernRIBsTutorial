//
//  LaunchGameWorkflow.swift
//  ModernRIBsTutorial
//
//  Created by BH on 2022/01/25.
//
import ModernRIBs
import RxSwift
import UIKit
import Foundation


public class LaunchGameWorkflow: Workflow<RootActionableItem> {
    public init(url: URL) {
        super.init()

        let gameId = parseGameId(from: url)

        self
            .onStep { (rootItem: RootActionableItem) -> Observable<(LoggedInActionableItem, ())> in
                rootItem.waitForLogin()
            }
            .onStep { (loggedInItem: LoggedInActionableItem, _) -> Observable<(LoggedInActionableItem, ())> in
                loggedInItem.launchGame(with: gameId)
            }
            .commit()
    }

    private func parseGameId(from url: URL) -> String? {
        let components = URLComponents(string: url.absoluteString)
        let items = components?.queryItems ?? []
        for item in items {
            if item.name == "gameId" {
                return item.value
            }
        }

        return nil
    }
}

