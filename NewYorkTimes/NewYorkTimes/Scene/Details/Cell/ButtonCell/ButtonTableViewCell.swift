//
//  ButtonTableViewCell.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import UIKit
import RxSwift

final class ButtonTableViewCell: TableViewCell {
    
    private var containerView = UIView()
    private var button = UIButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(button)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(30)
            $0.centerX.bottom.equalToSuperview()
        }
    }
    
    override func setupView() {
        super.setupView()
        
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .white
        
        button.backgroundColor = .systemGray6
        button.setCornersRadius(4)
    }
    
    func render(_ model: ButtonCellModel) {
        let buttonTitle = NSAttributedString(string: model.title,
                                             attributes: [.font: Style.Font.semiboldText,
                                                          .foregroundColor: UIColor.black.withAlphaComponent(0.8)])
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.rx.tap.bind(to: model.rx.didTapEvent).disposed(by: disposeBag)
    }
}
