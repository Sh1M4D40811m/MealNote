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
    
    init() {
        let firstData = Driver.just(SampleTestData.mealLogDataList)
        cellData = Driver.merge(firstData, fetchDataRelay.asDriver(onErrorJustReturn: []))
        openCalendar = didTapCalendarButton.asSignal()
        openDetail = didSelectRow.asSignal()
        
        subscribe()
    }
    
    private func subscribe() {
        Observable.merge(didTapPrevButton.asObservable(), didTapNextButton.asObservable())
            .map { _ in SampleTestData.newMealLogDataList }
            .bind(to: fetchDataRelay)
            .disposed(by: disposeBag)
    }
}

struct SampleTestData {
    static let mealLogDataList: [MealLogDataList] = [
        MealLogDataList.basic(
            value: MealLogData(
                image: UIImage(named: "samplePhoto"),
                type: .breakfast,
                title: "焼き鮭",
                tags: [],
                date: Date()
            ),
            screen: .diary
        ),
        MealLogDataList.basic(
            value: MealLogData(
                image: UIImage(named: "samplePhoto"),
                type: .lunch,
                title: "唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食",
                description: "いつもの定食屋でランチ。ごはん大盛り。キャベツおかわりした。",
                tags: ["外食", "食後血糖140以上", "揚げ物", "肉料理", "野菜", "汁物"],
                date: Date()
            ),
            screen: .diary
        ),
        MealLogDataList.basic(
            value: MealLogData(
                type: .snack,
                title: "プリン",
                tags: [],
                date: Date()
            ),
            screen: .diary
        ),
        MealLogDataList.basic(
            value: MealLogData(
                type: .snack,
                title: "ケーキ",
                tags: ["お菓子", "脂肪分"],
                date: Date()
            ),
            screen: .diary
        ),
        MealLogDataList.basic(
            value: MealLogData(
                type: .dinner,
                title: "カレー",
                description: "二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い",
                tags: [],
                date: Date()
            ),
            screen: .diary
        )
    ]
    
    static let newMealLogDataList: [MealLogDataList] = [
        MealLogDataList.basic(
            value: MealLogData(
                image: UIImage(named: "samplePhoto"),
                type: .breakfast,
                title: "焼き鮭",
                tags: [],
                date: Date()
            ),
            screen: .diary
        ),
        MealLogDataList.basic(
            value: MealLogData(
                image: UIImage(named: "samplePhoto"),
                type: .lunch,
                title: "唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食唐揚げ定食",
                description: "いつもの定食屋でランチ。ごはん大盛り。キャベツおかわりした。",
                tags: ["外食", "食後血糖140以上", "揚げ物", "肉料理", "野菜", "汁物"],
                date: Date()
            ),
            screen: .diary
        ),
        MealLogDataList.basic(
            value: MealLogData(
                type: .dinner,
                title: "カレー",
                description: "二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い",
                tags: [],
                date: Date()
            ),
            screen: .diary
        )
    ]
}
