//
//  TableViewCell.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 13.06.23.
//

import UIKit
import RxSwift

public protocol Reusable {
    static var reuseID: String { get }
}

public extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

/// Base protocol for all UITableViewCell
open class TableViewCell: UITableViewCell, Reusable {
    // MARK: - Properties

    public lazy var disposeBag = DisposeBag()

    // MARK: - Constructor

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupView()
        setupLocalization()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
        setupView()
        setupLocalization()
    }

    // MARK: - Fucntions

    open func setupView() {}

    open func setupConstraints() {}

    open func setupLocalization() {}
}
