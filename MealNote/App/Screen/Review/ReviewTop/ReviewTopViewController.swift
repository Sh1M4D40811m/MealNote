//
//  ReviewTopViewController.swift
//  MealNote
//
//  Created by mio on 2025/02/25.
//

import UIKit
import RxCocoa
import RxSwift

class ReviewTopViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sortButton: CircleButton!
    @IBOutlet private weak var filterButton: CircleButton!
    
    private let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: nil, action: nil)
    
    private let viewModel = ReviewTopViewModel()
    private let dataSource = MealLogDataSource()
    private let disposeBag = DisposeBag()
    
    weak var delegate: ReviewTopCoordinatorDelegate?
    
    static func instances() -> ReviewTopViewController {
        let storyboard = UIStoryboard(name: "ReviewTop", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ReviewTop") as! ReviewTopViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        bindViews()
        bindViewModel()
    }
    
    private func setupNavigationBar() {
        closeButton.tintColor = .systemTeal
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setupTableView() {
        dataSource.delegate = self
        tableView.delegate = self
        tableView.contentInset.bottom = 90
        tableView.register(UINib(nibName: "MealLogCell", bundle: nil), forCellReuseIdentifier: "MealLogCell")
    }
    
    private func bindViews() {
        closeButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.delegate?.dismiss()
            })
            .disposed(by: disposeBag)
        
        sortButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                print("pop SortSelect")
            })
            .disposed(by: disposeBag)
        
        filterButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.delegate?.openSettingCondition()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        viewModel.outputs.cellData
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension ReviewTopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ReviewTopViewController: UpdateRowHeightDelegate {
    func rowHeightDidChange(_ cell: MealLogCell) {
        UIView.performWithoutAnimation {
            if self.tableView.indexPath(for: cell) != nil {
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
    }
}
