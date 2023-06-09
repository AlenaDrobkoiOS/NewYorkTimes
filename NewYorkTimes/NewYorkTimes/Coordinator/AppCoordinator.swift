//
//  AppCoordinator.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 08.06.2023.
//

import UIKit
import RxSwift

/// General App Coordinator
final class AppCoordinator: Coordinator<Void> {
    
    struct Injections {
        let window: UIWindow
    }
    
    private let window: UIWindow
    
    private var navigationController = UINavigationController()
    private var serviceHolder = ServiceHolder()
    
    init(injections: Injections) {
        self.window = injections.window
        super.init()
    }
    
    @discardableResult // ignore return value
    override func start() -> Observable<Void> {
        setUp()
        coordinateToMain()
        return .never()
    }
    
    private func setUp() {
        setUpNC()
        setUpServices()
    }
    
    private func coordinateToMain() {
        let mainCoordinator = MainCoordinator(injections: .init(navigationController: navigationController,
                                                                serviceHolder: serviceHolder))
       coordinate(to: mainCoordinator)
    }
    
    /// Init some services, add services to service holder
    private func setUpServices() {
        let newsUseCase = UseCaseFactory.makeNewsUseCase()
        serviceHolder.add(NewsUseCaseType.self, for: newsUseCase)
        
        let alertService = AlertService()
        serviceHolder.add(AlertServiceType.self, for: alertService)
    }
    
    /// Set up navigation controller
    private func setUpNC() {
        navigationController.navigationBar.barTintColor = .white
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
