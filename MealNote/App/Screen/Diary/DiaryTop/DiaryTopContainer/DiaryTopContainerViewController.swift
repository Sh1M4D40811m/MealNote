//
//  DiaryTopContainerViewController.swift
//  MealNote
//
//  Created by mio on 2025/03/18.
//

import UIKit
import RxCocoa
import RxSwift

final class DiaryTopContainerViewController: UIViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var addButton: CircleButton!
    @IBOutlet private weak var reviewButton: UIButton!
    @IBOutlet private weak var tagButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    weak var delegate: DiaryTopContainerCoordinatorDelegate?
    weak var childVCDlegate: DiaryTopCoordinatorDelegate?
    
    private let disposeBag = DisposeBag()
    
    static func instances() -> DiaryTopContainerViewController {
        let storyboard = UIStoryboard(name: "DiaryTopContainer", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DiaryTopContainer") as! DiaryTopContainerViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addChildViewController()
        bindViews()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = L10n.diaryTopNavigationTitle
    }
    
    private func addChildViewController() {
        let childVC = DiaryTopViewController.instances()
        childVC.delegate = childVCDlegate
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParent: self)
    }
    
    private func bindViews() {
        addButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.delegate?.openDiaryForm()
            })
            .disposed(by: disposeBag)
        
        reviewButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.delegate?.openReviewTop()
            })
            .disposed(by: disposeBag)
        
        tagButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.delegate?.openEditTag()
            })
            .disposed(by: disposeBag)
        
        favoriteButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.delegate?.openEditFavorite()
            })
            .disposed(by: disposeBag)
    }
}
