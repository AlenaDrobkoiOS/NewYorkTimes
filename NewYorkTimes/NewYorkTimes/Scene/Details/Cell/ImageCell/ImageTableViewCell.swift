//
//  ImageTableViewCell.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import Foundation
import UIKit
import RxSwift

final class ImageTableViewCell: TableViewCell {
    
    private var containerView = UIView()
    private var posterImageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        
        disposeBag = DisposeBag()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(posterImageView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerY.left.right.equalToSuperview()
            $0.height.equalTo(250)
        }
    }
    
    override func setupView() {
        super.setupView()
        
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .white
        posterImageView.contentMode = .redraw
    }
    
    func render(_ model: ImageCellModel) {
        posterImageView.setImage(with: model.imageURL)
    }
}
