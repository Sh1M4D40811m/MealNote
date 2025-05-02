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
        viewModel.inputs.viewDidLoad.accept(())
        setupUI()
        bindViews()
        bindViewModel()
    }
    
    private func setupUI() {
        calendarButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        setupTableView()
    }
    
    private func setupTableView() {
        dataSource.delegate = self
        tableView.delegate = self
        tableView.contentInset.bottom = 40
        tableView.register(UINib(nibName: "MealLogCell", bundle: nil), forCellReuseIdentifier: "MealLogCell")
    }
    
    private func showDatePicker() {
        let calendarPickerVC = CalendarPickerViewController(
            selectedDate: viewModel.outputs.selectedDateValue,
            onDateSelected: { [weak self] selectedDate in
                self?.viewModel.inputs.didSelectDate.accept(selectedDate)
            }
        )
        present(calendarPickerVC, animated: true, completion: nil)
    }
    
    private func bindViews() {
        prevButton.rx.tap
            .bind(to: viewModel.inputs.didTapPrevButton)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(to: viewModel.inputs.didTapNextButton)
            .disposed(by: disposeBag)
        
        calendarButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.showDatePicker()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        viewModel.outputs.cellData
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.outputs.selectedDate
            .map { $0.toString(.dateWeekJp) }
            .drive(calendarButton.rx.title())
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
