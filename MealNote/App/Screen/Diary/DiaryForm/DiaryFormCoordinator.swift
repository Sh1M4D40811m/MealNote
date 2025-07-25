//
//  DiaryFormCoordinator.swift
//  MealNote
//
//  Created by mio on 2025/03/22.
//

import UIKit
import SwiftUI

protocol DiaryFormCoordinatorDelegate: AnyObject {
    func dismissComplete()
    func dismissCancel()
    func openEditTag()
}

final class DiaryFormCoordinator: Coordinator {
    private let parent: UIViewController!
    private weak var navigator: NavigationController!
    
    private lazy var dismissAction: (Bool) -> Void = { [weak self] isCancel in
        isCancel == true ? self?.dismissCancel() : self?.dismissComplete()
    }
    
    init(parent: UIViewController) {
        self.parent = parent
    }
    
    func start() {
        var view = DiaryFormView()
        view.dismissAction = dismissAction
        let vc = UIHostingController(rootView: view)
        let nav = NavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.setScrollEdgeWithoutSeparator()
        parent.present(nav, animated: true)
        self.navigator = nav
    }
}

extension DiaryFormCoordinator: DiaryFormCoordinatorDelegate {
    func dismissComplete() {
        navigator.dismiss(animated: true)
    }
    
    func dismissCancel() {
        navigator.dismiss(animated: true)
    }
    
    func openEditTag() {
        print("openEditTag")
    }
}
