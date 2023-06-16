//
//  BaseMainViewModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 13.06.23.
//

import Foundation
import RxSwift
import RxCocoa

/// Main screen base view model
class BaseMainViewModel: ViewModelProtocol {
    
    struct Injections {
        let serviceHolder: ServiceHolder
    }
    
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
    
    public var openArticle = PublishSubject<ArticleDataType>()
    
    init(injections: Injections) {}
    
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {}
}
