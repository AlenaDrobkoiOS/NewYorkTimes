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
        let viewModel = MainViewModel(injections: .init(serviceHolder: serviceHolder))
        let controller = MainViewController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: false)
        
        viewModel.openArticle
            .flatMap { article in
                self.openArticleDetails(with: article)
            }
            .bind { result in
                switch result {
                case .openURL(let url):
                    print("Open Url - \(url.absoluteString)")
                case .dismiss:
                    print("Details screen dismissed")
                }
            }
            .disposed(by: disposeBag)
        
        return .never()
    }
    
    private func openArticleDetails(with article: ArticleDataType) -> Observable<DetailsCoordinatorResult>  {
        let coordinator = DetailsCoordinator(injections: .init(navigationController: navigationController,
                                                               serviceHolder: serviceHolder,
                                                               article: article))
        return coordinate(to: coordinator)
    }
}
