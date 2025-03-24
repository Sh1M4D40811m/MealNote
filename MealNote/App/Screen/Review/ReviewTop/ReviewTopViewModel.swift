//
//  ReviewTopViewModel.swift
//  MealNote
//
//  Created by mio on 2025/03/12.
//

import UIKit
import RxSwift
import RxCocoa


protocol ReviewTopViewModelInput: AnyObject {
    
}

protocol ReviewTopViewModelOutput: AnyObject {
    var cellData: Driver<[MealLogDataList]> { get }
}

protocol ReviewTopViewModelType {
    var inputs: ReviewTopViewModelInput { get }
    var outputs: ReviewTopViewModelOutput { get }
}

final class ReviewTopViewModel: ReviewTopViewModelInput, ReviewTopViewModelOutput, ReviewTopViewModelType  {
    var cellData: Driver<[MealLogDataList]>
    
    var inputs: ReviewTopViewModelInput { self }
    var outputs: ReviewTopViewModelOutput { self }
    
    init() {
        cellData = Driver.just([
            MealLogDataList.basic(
                value: MealLogData(
                    image: UIImage(named: "samplePhoto"),
                    type: .breakfast,
                    title: "焼き鮭",
                    tags: [],
                    date: Date()
                ),
                screen: .review
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
                screen: .review
            ),
            MealLogDataList.basic(
                value: MealLogData(
                    type: .snack,
                    title: "プリン",
                    tags: [],
                    date: Date()
                ),
                screen: .review
            ),
            MealLogDataList.basic(
                value: MealLogData(
                    type: .snack,
                    title: "ケーキ",
                    tags: ["お菓子", "脂肪分"],
                    date: Date()
                ),
                screen: .review
            ),
            MealLogDataList.basic(
                value: MealLogData(
                    type: .dinner,
                    title: "カレー",
                    description: "二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い",
                    tags: [],
                    date: Date()
                ),
                screen: .review
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
                screen: .review
            ),
            MealLogDataList.basic(
                value: MealLogData(
                    type: .snack,
                    title: "プリン",
                    tags: [],
                    date: Date()
                ),
                screen: .review
            ),
            MealLogDataList.basic(
                value: MealLogData(
                    type: .snack,
                    title: "ケーキ",
                    tags: ["お菓子", "脂肪分"],
                    date: Date()
                ),
                screen: .review
            ),
            MealLogDataList.basic(
                value: MealLogData(
                    type: .dinner,
                    title: "カレー",
                    description: "二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い二日目のカレーは旨い",
                    tags: [],
                    date: Date()
                ),
                screen: .review
            )
        ])
    }
}
