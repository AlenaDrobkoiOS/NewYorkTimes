//
//  UIWindow.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 14.06.23.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last
    }
}
