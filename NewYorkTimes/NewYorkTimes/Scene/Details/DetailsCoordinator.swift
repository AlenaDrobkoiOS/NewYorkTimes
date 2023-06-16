//
//  DetailsCoordinator.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import UIKit
import RxSwift

enum DetailsCoordinatorResult {
    case openURL(URL)
    case dismiss
}

/// Details screen coordinator
final class DetailsCoordinator: Coordinator<DetailsCoordinatorResult> {
    struct Injections {
        let navigationController: UINavigationController
        let serviceHolder: ServiceHolder
        let article: ArticleDataType
    }

    private let navigationController: UINavigationController
    private let serviceHolder: ServiceHolder
    private let article: ArticleDataType
    
    init(injections: Injections) {
        self.navigationController = injections.navigationController
        self.serviceHolder = injections.serviceHolder
        self.article = injections.article
    }
    
    override func start() -> Observable<CoordinationResult> {
        let injections = DetailsViewModel.Injections(serviceHolder: self.serviceHolder, article: article)
        let viewModel = DetailsViewModel(injections: injections)
        let controller = DetailsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: true)
        
        return setupRouting(viewModel: controller.viewModel)
    }
    
    private func setupRouting(viewModel: BaseDetailsViewModel) -> Observable<CoordinationResult> {
        let openURLEvent = viewModel.openURL
            .map { url in return CoordinationResult.openURL(url) }
        
        let dismissEvent = viewModel.dismiss
            .map { url in return CoordinationResult.dismiss }
        
        return Observable.merge([dismissEvent, openURLEvent])
    }
}
