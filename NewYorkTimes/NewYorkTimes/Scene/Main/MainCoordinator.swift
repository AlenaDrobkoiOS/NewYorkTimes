//
//  MainCoordinator.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 13.06.23.
//

import UIKit
import RxSwift

/// Main screen coordinator
final class MainCoordinator: Coordinator<Void> {
    struct Injections {
        let navigationController: UINavigationController
        let serviceHolder: ServiceHolder
    }

    private let navigationController: UINavigationController
    private let serviceHolder: ServiceHolder
    
    init(injections: Injections) {
        self.navigationController = injections.navigationController
        self.serviceHolder = injections.serviceHolder
    }
    
    @discardableResult // ignore return value
    override func start() -> Observable<Void> {
        let injections = MainViewModel.Injections(serviceHolder: self.serviceHolder)
        let viewModel = MainViewModel(injections: injections)
        let controller = MainViewController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: false)
        
        return .never()
    }
}
