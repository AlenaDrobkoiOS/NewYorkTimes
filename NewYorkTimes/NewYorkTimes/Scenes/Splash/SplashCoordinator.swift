//
//  SplashCoordinator.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 08.06.2023.
//

import UIKit
import RxSwift

/// Splash screen coordinator
final class SplashCoordinator: Coordinator<Void> {
    struct Injections {
        let navigationController: UINavigationController
    }

    private var navigationController: UINavigationController
    
    init(injections: Injections) {
        self.navigationController = injections.navigationController
    }
    
    @discardableResult // ignore return value
    override func start() -> Observable<Void> {
        if let controller: SplashViewController = Storyboard.splash.instantiateViewController() {
            navigationController.pushViewController(controller, animated: false)
        }
        
        return .never()
    }
}
