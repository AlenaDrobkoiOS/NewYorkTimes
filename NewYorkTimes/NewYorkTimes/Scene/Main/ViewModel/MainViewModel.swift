//
//  MainViewModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 13.06.23.
//

import Foundation
import RxSwift
import RxCocoa
import Combine

/// Main screen view model
final class MainViewModel: BaseMainViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    private let newsUseCase: NewsUseCaseType
    private let alertService: AlertServiceType
    
    private var currentCategory: NewsCategory = .general {
        didSet {
            page = 1
            hasMoreInfo.accept(true)
            
            articles = []
            tableItems.accept([])
            
            fetchNews()
        }
    }
    private var articles: [ArticleDataType] = []
    private var page = 1
    private let pageSize = 10
    
    private var tableItems: BehaviorRelay<[MainCellModel]> = BehaviorRelay<[MainCellModel]>(value: [])
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private var hasMoreInfo = BehaviorRelay<Bool>(value: true)
    
    override init(injections: Injections) {
        newsUseCase = injections.serviceHolder.get(by: NewsUseCaseType.self)
        alertService = injections.serviceHolder.get(by: AlertServiceType.self)
        
        super.init(injections: injections)
        
        fetchNews()
    }
    
    private func fetchNews() {
        isLoading.accept(true)
        
        let data = NewsRequestData(country: Constants.country,
                                   category: currentCategory.rawValue,
                                   pageSize: pageSize,
                                   page: page)
        newsUseCase.getTopHeadlines(data)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.alertService.show.onNext(.error(error))
                case .finished:
                    print("GetTopHeadlines request finished")
                }
            } receiveValue: { [weak self] element in
                guard let self else { return }
                
                if let articles = element.articles {
                    self.articles += articles
                    self.tableItems.accept(tableItems.value + articles.map({ MainCellModel(data: $0) }))
                } else {
                    self.alertService.show.onNext(.warning(Localizationable.Global.noElementsWarning.localized))
                }
                
                
                if let totalResults = element.totalResults {
                    self.hasMoreInfo.accept((totalResults - self.pageSize * self.page) > 0 )
                } else {
                    self.hasMoreInfo.accept(false)
                    self.alertService.show.onNext(.warning(Localizationable.Global.countWarning.localized))
                }
                
                if let error = element.message {
                    let networkError = NetworkError.serverError(error: error)
                    self.alertService.show.onNext(.error(networkError))
                }
                
                self.isLoading.accept(false)
            }
            .store(in: &cancellables)
    }
    
    override func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        input.disposeBag.insert([
            setUpLoadMore(with: input.loadMore),
            setUpCategorySelected(with: input.categorySelected),
            setUpItemsSelected(with: input.itemsSelected)
        ])
        
        let output = Output(
            tableItems: tableItems.asDriver(),
            isLoading: isLoading.asObservable(),
            hasMoreInfo: hasMoreInfo.asObservable()
        )
        outputHandler(output)
    }
    
    private func setUpCategorySelected(with signal: Observable<String>) -> Disposable {
        signal
            .bind(onNext: { [weak self] value in
                guard let category = NewsCategory(rawValue: value),
                      self?.currentCategory != category
                else { return }
                
                self?.currentCategory = category
            })
    }
    
    private func setUpLoadMore(with signal: Observable<Void>) -> Disposable {
        signal
            .bind(onNext: { [weak self] _ in
                guard let self, !self.isLoading.value, self.hasMoreInfo.value else { return }
                
                self.page += 1
                self.fetchNews()
            })
    }
    
    private func setUpItemsSelected(with signal: Observable<Int>) -> Disposable {
        return signal
            .map({ [weak self] index -> ArticleDataType? in
                guard let self, self.articles.count > index else { return nil }
                return self.articles[index]
            })
            .bind { [weak self] article in
                guard let self, let article else { return }
                self.openArticle.onNext(article)
            }
    }
}
