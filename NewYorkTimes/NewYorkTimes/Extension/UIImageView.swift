//
//  UIImageView.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 13.06.23.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String?) {
        if let path = urlString,
           let url = URL(string: path) {
            setImage(with: url)
        } else {
            self.image = Style.Images.placeholder.image
        }
    }
    
    func setImage(with url: URL) {
        kf.setImage(
            with: url,
            placeholder: Style.Images.placeholder.image,
            options: [
                .fromMemoryCacheOrRefresh,
                .diskCacheExpiration(.seconds(3600)),
                .callbackQueue(.mainAsync)
            ])
    }
}
