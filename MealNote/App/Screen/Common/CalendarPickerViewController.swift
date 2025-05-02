//
//  CalendarPickerViewController.swift
//  MealNote
//
//  Created by shimadamio on 2025/05/01.
//

import UIKit
import RxSwift
import RxCocoa

class CalendarPickerViewController: UIViewController {
    private let selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.set, for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.cancel, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.tintColor = .systemTeal
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private var selectedDate: Date
    private let onDateSelected: (Date) -> Void
    
    private var disposeBag = DisposeBag()
    
    init(selectedDate: Date, onDateSelected: @escaping (Date) -> Void) {
        self.selectedDate = selectedDate
        self.onDateSelected = onDateSelected
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViews()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        datePicker.date = selectedDate
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.addSubview(datePicker)
        containerView.addSubview(selectButton)
        containerView.addSubview(cancelButton)

        // containerViewの制約
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 320),
            containerView.heightAnchor.constraint(equalToConstant: 400)
        ])

        // DatePickerの制約
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 300)
        ])

        // 「日付を選択」ボタンの制約
        NSLayoutConstraint.activate([
            selectButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            selectButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            selectButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32)
        ])

        // 「閉じる」ボタンの制約
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32)
        ])
    }
    
    private func bindViews() {
        selectButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.selectDate()
            })
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap.asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.close()
            })
            .disposed(by: disposeBag)
    }

    private func selectDate() {
        selectedDate = datePicker.date
        onDateSelected(selectedDate)
        dismiss(animated: true, completion: nil)
    }

    private func close() {
        dismiss(animated: true, completion: nil)
    }
}
