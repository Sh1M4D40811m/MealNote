//
//  ReviewTopCoordinator.swift
//  MealNote
//
//  Created by mio on 2025/02/27.
//

import UIKit

protocol ReviewTopCoordinatorDelegate: AnyObject {
    func dismiss()
    func openSettingCondition()
}

final class ReviewTopCoordinator: Coordinator {
    private let parent: UIViewController!
    private weak var navigator: NavigationController!
    
    init(parent: UIViewController) {
        self.parent = parent
    }
    
    func start() {
        let vc = ReviewTopViewController.instances()
        vc.delegate = self
        let nav = NavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.setScrollEdgeWithoutSeparator()
        parent.present(nav, animated: true)
        self.navigator = nav
    }
}

extension ReviewTopCoordinator: ReviewTopCoordinatorDelegate {
    func dismiss() {
        navigator.dismiss(animated: true)
    }
    
    func openSettingCondition() {
        print("openSettingCondition")
    }
}
