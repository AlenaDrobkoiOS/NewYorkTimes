//
//  DetailsViewModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import Foundation
import RxSwift
import RxCocoa

/// Details screen view model
final class DetailsViewModel: BaseDetailsViewModel {
    private let bag = DisposeBag()
    private let alertService: AlertServiceType
    private var tableItems = BehaviorRelay<[DetailsCellModel]>(value: [])

    override init(injections: Injections) {
        alertService = injections.serviceHolder.get(by: AlertServiceType.self)
        
        super.init(injections: injections)
        
        setUpInfo(injections.article)
    }
    
    private func setUpInfo(_ article: ArticleDataType) {
        var info: [DetailsCellModel] = []
        info.append(.text(TextCellModel(text: article.title, type: .title)))
        info.append(.text(TextCellModel(text: article.source?.name, type: .source)))
        info.append(.text(TextCellModel(text: article.publishedAt?.getDateString(), type: .date)))
        info.append(.image(ImageCellModel(imageURL: article.urlToImage)))
        info.append(.text(TextCellModel(text: article.description, type: .content)))
        info.append(.text(TextCellModel(text: article.author, type: .author)))
        info.append(.button(generateButtonModel(article.url)))
        
        tableItems.accept(info)
    }
    
    private func generateButtonModel(_ articleUrl: String?) -> ButtonCellModel {
        let model = ButtonCellModel(title: Localizationable.Global.openInfo.localized)
        model.tapObservable()
            .subscribe(onNext: { [weak self] in
                guard let self,
                      let urlPath = articleUrl,
                      let url = URL(string: urlPath)
                else {
                    self?.alertService.show.onNext(.warning(Localizationable.Global.urlWarning.localized))
                    return
                }
                
                UIApplication.shared.open(url)
                self.openURL.onNext(url)
            })
            .disposed(by: bag)
        return model
    }

    override func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        input.disposeBag.insert([ input.backTapped.bind(to: dismiss) ])
        
        let output = Output(tableItems: tableItems.asDriver())
        outputHandler(output)
    }
}
