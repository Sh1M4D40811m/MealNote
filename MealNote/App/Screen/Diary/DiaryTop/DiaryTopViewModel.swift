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
    var didSelectRow: PublishRelay<Void> { get }
    var didSelectDate: PublishRelay<Date> { get }
}

protocol DiaryTopViewModelOutput: AnyObject {
    var cellData: Driver<[MealLogDataList]> { get }
    var selectedDate: Driver<Date> { get }
    var selectedDateValue: Date { get }
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
    let didSelectRow = PublishRelay<Void>()
    let didSelectDate = PublishRelay<Date>()
    
    // Output
    var cellData: Driver<[MealLogDataList]> { fetchDataRelay.asDriver() }
    var selectedDate: Driver<Date> { selectedDateRelay.asDriver() }
    var selectedDateValue: Date { selectedDateRelay.value }
    let openDetail: Signal<Void>
    
    private let fetchDataRelay = BehaviorRelay<[MealLogDataList]>(value: [])
    private let selectedDateRelay = BehaviorRelay<Date>(value: Date())
    private var disposeBag = DisposeBag()
    private let repository = DiaryTopRepository()
    
    init() {
        openDetail = didSelectRow.asSignal()
        subscribe()
    }
    
    private func subscribe() {
        // TODO: UserIDの取得
        Observable.merge(viewDidLoad.withLatestFrom(selectedDateRelay), selectedDateRelay.asObservable())
            .flatMap { self.repository.fetchDiaryTop(userID: 1, date: $0.toString(.dateHyphen)) }
            .subscribe(with: self, onNext: { owner, value in
                let mealLogDataList = value.meals.map { meal in
                    MealLogDataList.basic(value: meal, screen: .diary)
                }
                owner.fetchDataRelay.accept(mealLogDataList)
            }, onError: { _, error  in
                // TODO: エラーハンドリング実装
                print("error", error)
            })
            .disposed(by: disposeBag)
        
        didSelectDate
            .bind(to: selectedDateRelay)
            .disposed(by: disposeBag)
        
        didTapPrevButton
            .withLatestFrom(selectedDateRelay)
            .map { $0.addDay(-1) }
            .bind(to: selectedDateRelay)
            .disposed(by: disposeBag)
        
        didTapNextButton
            .withLatestFrom(selectedDateRelay)
            .map { $0.addDay(1) }
            .bind(to: selectedDateRelay)
            .disposed(by: disposeBag)
    }
}
