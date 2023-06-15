//
//  MainViewModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 13.06.23.
//

import Foundation
import RxSwift
import RxCocoa

/// Main screen view model
final class MainViewModel {
    
    struct Injections {
        let serviceHolder: ServiceHolder
    }
    
    private let bag = DisposeBag()
    
    private let newsUseCase: NewsUseCaseType
    private let alertService: AlertServiceType
    
    private var currentCategory: NewsCategory = .general
    private var articles: [ArticleDataType] = []
    private var page = 1
    private let pageSize = 10
    
    private var tableItems: BehaviorRelay<[MainCellModel]> = BehaviorRelay<[MainCellModel]>(value: [])
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private var hasMoreInfo = BehaviorRelay<Bool>(value: true)
    
    var openArticle = PublishSubject<ArticleDataType>()
    
    init(injections: Injections) {
        self.newsUseCase = injections.serviceHolder.get(by: NewsUseCaseType.self)
        self.alertService = injections.serviceHolder.get(by: AlertServiceType.self)
        
        self.fetchNews()
    }
    
    private func fetchNews() {
        self.isLoading.accept(true)
        
        let data = NewsRequestData(country: Constants.country,
                                   category: currentCategory.rawValue,
                                   pageSize: pageSize,
                                   page: page)
        
        newsUseCase.getTopHeadlines(data)
            .subscribe(onSuccess: { [weak self] element in
                guard let self = self else { return }
                
                let articles = element.articles ?? []
                let totalResults = element.totalResults ?? 0
                
                self.articles += articles
                self.tableItems.accept(tableItems.value + articles.map({ MainCellModel(data: $0) }))
                self.hasMoreInfo.accept((totalResults - self.pageSize * self.page) > 0 )
                self.isLoading.accept(false)
            }, onFailure: { [weak self] error in
                self?.alertService.show.onNext(.error(error))
            })
            .disposed(by: bag)
    }
}

extension MainViewModel: ViewModelProtocol {
    internal struct Input {
        let categorySelected: Observable<String>
        let itemsSelected: Observable<Int>
        let loadMore: Observable<Void>
        let disposeBag: DisposeBag
    }
    
    internal struct Output {
        let tableItems: Driver<[MainCellModel]>
        let isLoading: Observable<Bool>
        let hasMoreInfo: Observable<Bool>
    }
    
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        input.disposeBag.insert([
            setUpLoadMore(with: input.loadMore),
            setUpCategorySelected(with: input.categorySelected),
            setUpItemsSelected(with: input.itemsSelected, inside: articles)
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
            .bind(onNext: { value in
                guard let category = NewsCategory(rawValue: value) else { return }
                
                if self.currentCategory != category {
                    self.currentCategory = category
                    self.page = 1
                    
                    self.articles = []
                    self.tableItems.accept([])
                    
                    self.fetchNews()
                }
            })
    }
    
    private func setUpLoadMore(with signal: Observable<Void>) -> Disposable {
        signal
            .bind(onNext: { _ in
                if !self.isLoading.value && self.hasMoreInfo.value {
                    self.page += 1
                    self.fetchNews()
                }
            })
    }
    
    private func setUpItemsSelected(with signal: Observable<Int>, inside array: [ArticleDataType]) -> Disposable {
        signal
            .filter({ $0 < array.count })
            .map({ array[$0] })
            .bind(to: self.openArticle)
    }
}
