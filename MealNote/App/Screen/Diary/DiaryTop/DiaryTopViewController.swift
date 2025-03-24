//
//  DiaryTopViewController.swift
//  MealNote
//
//  Created by mio on 2025/02/25.
//

import UIKit
import RxCocoa
import RxSwift

final class DiaryTopViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var calendarButton: UIButton!
    
    private let viewModel = DiaryTopViewModel()
    private let dataSource = MealLogDataSource()
    private let disposeBag = DisposeBag()
    
    weak var delegate: DiaryTopCoordinatorDelegate?
    
    static func instances() -> DiaryTopViewController {
        let storyboard = UIStoryboard(name: "DiaryTop", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DiaryTop") as! DiaryTopViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViews()
        bindViewModel()
    }
    
    private func setupTableView() {
        dataSource.delegate = self
        tableView.delegate = self
        tableView.contentInset.bottom = 40
        tableView.register(UINib(nibName: "MealLogCell", bundle: nil), forCellReuseIdentifier: "MealLogCell")
    }
    
    private func bindViews() {
        prevButton.rx.tap
            .bind(to: viewModel.inputs.didTapPrevButton)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(to: viewModel.inputs.didTapNextButton)
            .disposed(by: disposeBag)
        
        calendarButton.rx.tap
            .bind(to: viewModel.inputs.didTapCalendarButton)
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        viewModel.outputs.cellData
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.outputs.openCalendar
            .emit(with: self, onNext: { _, _ in
                print("pop Calender")
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.openDetail
            .emit(with: self, onNext: { owner, _ in
                owner.delegate?.openDiaryDetail()
            })
            .disposed(by: disposeBag)
    }
}

extension DiaryTopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.inputs.didSelectRow.accept(())
    }
}

extension DiaryTopViewController: UpdateRowHeightDelegate {
    func rowHeightDidChange(_ cell: MealLogCell) {
        UIView.performWithoutAnimation {
            if self.tableView.indexPath(for: cell) != nil {
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
    }
}
