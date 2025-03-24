//
//  DiaryTopContainerCoordinator.swift
//  MealNote
//
//  Created by mio on 2025/03/18.
//

import UIKit

protocol DiaryTopContainerCoordinatorDelegate: AnyObject {
    func openDiaryEntry()
    func openReviewTop()
    func openEditTag()
    func openEditFavorite()
}

final class DiaryTopContainerCoordinator: Coordinator {
    private let navigator: NavigationController!
    private var diaryEntryCoordinator: DiaryEntryCoordinator?
    private var reviewTopCoordinator: ReviewTopCoordinator?
    
    init(navigator: NavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let vc = DiaryTopContainerViewController.instances()
        vc.delegate = self
        vc.childVCDlegate = self
        navigator.setViewControllers([vc], animated: false)
    }
}

extension DiaryTopContainerCoordinator: DiaryTopContainerCoordinatorDelegate {
    func openDiaryEntry() {
        diaryEntryCoordinator = DiaryEntryCoordinator(parent: navigator)
        diaryEntryCoordinator?.start()
    }
    
    func openReviewTop() {
        reviewTopCoordinator = ReviewTopCoordinator(parent: navigator)
        reviewTopCoordinator?.start()
    }
    
    func openEditTag() {
        print("openEditTag")
    }
    
    func openEditFavorite() {
        print("openEditFavorite")
    }
}

extension DiaryTopContainerCoordinator: DiaryTopCoordinatorDelegate {
    func openDiaryDetail() {
        print("openDiaryDetail")
    }
}
