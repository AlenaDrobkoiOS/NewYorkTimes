//
//  TextTableCell.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import UIKit
import RxSwift

/// Details screen text cell - contains text by type
final class TextTableCell: TableViewCell {
    
    private var containerView = UIView()
    private var infoLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        infoLabel.text = nil
        
        disposeBag = DisposeBag()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(infoLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(15)
            $0.centerX.bottom.equalToSuperview()
        }
    }
    
    override func setupView() {
        super.setupView()
        
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .white
        
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .left
        infoLabel.textColor = .darkText
        infoLabel.font = Style.Font.regularMidleText
    }
    
    func render(_ model: TextCellModel) {
        infoLabel.text = model.text
        
        switch model.type {
        case .title:
            infoLabel.font = Style.Font.boldText
        case .content:
            infoLabel.textAlignment = .natural
        case .date:
            infoLabel.textColor = .gray
            infoLabel.snp.updateConstraints({ make in
                make.top.equalToSuperview().offset(2)
            })
        case .author:
            infoLabel.textAlignment = .right
            infoLabel.font = Style.Font.regularSmallText
        case .source:
            infoLabel.textColor = .gray
            infoLabel.font = Style.Font.semiboldText
        }
    }
}
