//
//  Storyboard.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 08.06.2023.
//

import UIKit

/// Helps to call storyboards
struct Storyboard {
    static let splash = UIStoryboard(name: "Splash", bundle: nil)
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self.self)
    }
}

extension UIStoryboard {
     func instantiateViewController<T: StoryboardIdentifiable>() -> T? {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
    }
}

extension UIViewController: StoryboardIdentifiable { }
