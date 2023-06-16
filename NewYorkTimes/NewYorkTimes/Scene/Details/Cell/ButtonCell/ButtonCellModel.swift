//
//  ButtonCellModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 16.06.23.
//

import RxSwift

/// Details screen button cell data model with tapObservable
final class ButtonCellModel: ReactiveCompatible {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    fileprivate let buttonTapEvent = PublishSubject<Void>()
    
    func tapObservable() -> Observable<Void> {
        return buttonTapEvent.asObservable()
    }
}

// MARK: - Reactive Ext

extension Reactive where Base: ButtonCellModel {
    var didTapEvent: Binder<Void> {
        return Binder(base) { base, _ in
            base.buttonTapEvent.onNext(())
        }
    }
}
