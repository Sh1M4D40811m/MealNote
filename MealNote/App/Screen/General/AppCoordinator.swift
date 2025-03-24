//
//  AppCoordinator.swift
//  MealNote
//
//  Created by mio on 2025/02/26.
//

import UIKit

final class AppCoordinator: Coordinator {
    var window: UIWindow
    var navigationController: NavigationController
    var diaryTopContainerCoordinator: DiaryTopContainerCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = NavigationController()
        diaryTopContainerCoordinator = DiaryTopContainerCoordinator(navigator: navigationController)
    }
    
    func start() {
        diaryTopContainerCoordinator?.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
