//
//  DiaryTopViewModel.swift
//  MealNote
//
//  Created by mio on 2025/03/06.
//

import UIKit
import RxSwift
import RxCocoa

protocol DiaryTopViewModelInput: AnyObject {
    var viewDidLoad: PublishRelay<Void> { get }
    var didTapPrevButton: PublishRelay<Void> { get }
    var didTapNextButton: PublishRelay<Void> { get }
    var didTapCalendarButton: PublishRelay<Void> { get }
    var didSelectRow: PublishRelay<Void> { get }
}

protocol DiaryTopViewModelOutput: AnyObject {
    var cellData: Driver<[MealLogDataList]> { get }
    var openCalendar: Signal<Void> { get }
    var openDetail: Signal<Void> { get }
}

protocol DiaryTopViewModelType {
    var inputs: DiaryTopViewModelInput { get }
    var outputs: DiaryTopViewModelOutput { get }
}

final class DiaryTopViewModel: DiaryTopViewModelInput, DiaryTopViewModelOutput, DiaryTopViewModelType  {
    var inputs: DiaryTopViewModelInput { self }
    var outputs: DiaryTopViewModelOutput { self }
    
    // Input
    let viewDidLoad = PublishRelay<Void>()
    let didTapPrevButton = PublishRelay<Void>()
    let didTapNextButton = PublishRelay<Void>()
    let didTapCalendarButton = PublishRelay<Void>()
    let didSelectRow = PublishRelay<Void>()
    
    // Output
    let cellData: Driver<[MealLogDataList]>
    let openCalendar: Signal<Void>
    let openDetail: Signal<Void>
    
    let fetchDataRelay = PublishRelay<[MealLogDataList]>()
    private var disposeBag = DisposeBag()
    
    private let repository = DiaryTopRepository()
    
    init() {
        cellData = fetchDataRelay.asDriver(onErrorJustReturn: [])
        openCalendar = didTapCalendarButton.asSignal()
        openDetail = didSelectRow.asSignal()
        subscribe()
    }
    
    private func subscribe() {
        // TODO: UserID・Dateの取得
        viewDidLoad
            .flatMap { self.repository.fetchDiaryTop(userID: 1, date: "2025-04-16") }
            .subscribe(with: self, onNext: { owner, value in
                print(value.date)
                let mealLogDataList = value.meals.map { meal in
                    MealLogDataList.basic(value: meal, screen: .diary)
                }
                owner.fetchDataRelay.accept(mealLogDataList)
            }, onError: { _, error  in
                // TODO: エラーハンドリング実装
                print("error", error)
            })
            .disposed(by: disposeBag)
    }
}
