//
//  BaseDetailsViewModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import Foundation
import RxSwift
import RxCocoa

/// Details screen base view model
class BaseDetailsViewModel: ViewModelProtocol {
    struct Injections {
        let serviceHolder: ServiceHolder
        let article: ArticleDataType
    }
    
    internal struct Input {
        var backTapped: Observable<Void>
        var disposeBag: DisposeBag
    }
    
    internal struct Output {
        var tableItems: Driver<[DetailsCellModel]>
    }
    
    var openURL = PublishSubject<URL>()
    var dismiss = PublishSubject<Void>()
    
    init(injections: Injections) {}
    
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {}
}
