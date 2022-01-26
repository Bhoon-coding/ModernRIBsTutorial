//
//  AppDelegate.swift
//  ModernRIBsTutorial
//
//  Created by Ppop on 2021/12/28.
//

import ModernRIBs
import RxSwift
import UIKit

// 1. 추후 앱별 URL 처리 로직을 포함하는 구체적인 클래스에 의해 구현됩니다.
protocol UrlHandler: AnyObject {
    func handle(_ url: URL)
}

/// Game app delegate.
@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {

    /// The window.
    public var window: UIWindow?

    /// Tells the delegate that the launch process is almost done and the app is almost ready to run.
    ///
    /// - parameter application: Your singleton app object.
    /// - parameter launchOptions: A dictionary indicating the reason the app was launched (if any). The contents of
    ///   this dictionary may be empty in situations where the user launched the app directly. For information about
    ///   the possible keys in this dictionary and how to handle them, see Launch Options Keys.
    /// - returns: false if the app cannot handle the URL resource or continue a user activity, otherwise return true.
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        
        let result = RootBuilder(dependency: AppComponent()).build()
        launchRouter = result.launchRouter
        urlHandler = result.urlHandler
        launchRouter?.launch(from: window)

        return true
    }
    
    // 3. 딥링크가 보내질때 실행되는 AppDelegate의 메소드 구현.
    // deprecated 아래 메소드 사용
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        urlHandler?.handle(url)
        return true
    }
//    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        urlHandler?.handle(url)
//        return true
//    }
    // MARK: - Private

    private var launchRouter: LaunchRouting?
    // 2. URL handler에 대한 참조를 AppDelegate에 저장 후 딥링크를 처리하도록 요청하기 위해 변수 설정
    private var urlHandler: UrlHandler?
}
