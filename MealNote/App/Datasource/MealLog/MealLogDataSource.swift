//
//  MealLogDataSource.swift
//  MealNote
//
//  Created by mio on 2025/03/01.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class MealLogDataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {
    
    typealias Element = [MealLogDataList]
    private var items: [(value: MealLogDataList, reusableId: String)] = []
    
    weak var delegate: UpdateRowHeightDelegate?
    
    override init() {}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (value, reusableId) = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath)
        configure(with: cell, value: value)
        return cell
    }

    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        Binder(self) { dataSource, element in
            dataSource.set(items: element)
            tableView.reloadData()
        }
        .on(observedEvent)
    }
    
    private func set(items: [MealLogDataList]) {
        self.items = items.map { ($0, String(describing: $0.cellClass)) }
    }
    
    private func configure(with cell: UITableViewCell, value: MealLogDataList) {
        switch (cell, value) {
        case let (cell as MealLogCell, value):
            cell.delegate = delegate
            cell.configure(with: value)
        default:
            fatalError()
        }
    }
}
