//
//  MainTableViewCell.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 13.06.23.
//

import UIKit
import RxSwift

final class MainTableViewCell: TableViewCell {
    
    private var containerView = UIView()
    private var posterImageView = UIImageView()
    private var titleLabel = UILabel()
    private var dateLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        dateLabel.text = nil
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10,
                                                                               left: 10,
                                                                               bottom: 10,
                                                                               right: 10))
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    
        contentView.addSubview(containerView)
        
        [posterImageView, titleLabel, dateLabel].forEach { view in
            containerView.addSubview(view)
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.left.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.45)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.left.equalTo(posterImageView.snp.right).offset(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(titleLabel.snp.right)
            $0.bottom.equalTo(posterImageView.snp.bottom).inset(10)
        }
    }
    
    override func setupView() {
        super.setupView()
        
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .white
        
        posterImageView.contentMode = .redraw
        posterImageView.setCornersRadius(8)
        
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .darkText
        titleLabel.font = Style.Font.mediumText
        
        dateLabel.numberOfLines = 1
        dateLabel.textColor = .gray
        dateLabel.font = Style.Font.regularSmallText
    }
    
    func render(_ model: MainCellModel) {
        posterImageView.setImage(with: model.imageURL)
        titleLabel.text = model.title
        dateLabel.text = model.date
    }
}
