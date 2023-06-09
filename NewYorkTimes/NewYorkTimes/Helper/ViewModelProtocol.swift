//
//  ViewModelProtocol.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 09.06.23.
//

import Foundation

public protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input,
                   outputHandler: @escaping (_ output: Output) -> Void)
}
