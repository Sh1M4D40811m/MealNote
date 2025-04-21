//
//  DiaryTopRepository.swift
//  MealNote
//
//  Created by shimadamio on 2025/04/16.
//

import RxSwift

protocol DiaryTopRepositoryProtocol {
    func fetchDiaryTop(userID: Int, date: String) -> Single<MealLogList>
}

class DiaryTopRepository: DiaryTopRepositoryProtocol {
    private let apiClient = APIClient()

    func fetchDiaryTop(userID: Int, date: String) -> Single<MealLogList> {
        return apiClient.request(APIRouter.getDiaryTop(userID: userID, date: date))
    }
}
