//
//  MealLogCell.swift
//  MealNote
//
//  Created by mio on 2025/03/01.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa
import RxDataSources

protocol UpdateRowHeightDelegate: AnyObject {
    func rowHeightDidChange(_ cell: MealLogCell)
}

final class MealLogCell: UITableViewCell {
    @IBOutlet private weak var photo: UIImageView!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var collectionViewContainer: UIStackView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    private var tagItems: [String] = []
    private let disposeBag = DisposeBag()
    private let tagsSubject = BehaviorSubject<[String]>(value: [])
    private var dataSource = RxCollectionViewSectionedReloadDataSource<TagSection>(
        configureCell: { _, collectionView, indexPath, tag in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
            cell.setTitle(tag)
            return cell
        }
    )
    
    struct TagSection {
        var items: [String]
    }
    
    weak var delegate: UpdateRowHeightDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCollectionViewHeight()
    }
    
    func configure(with value: MealLogDataList) {
        switch value {
        case .basic(let data, let screen):
            photo.kf.setImage(with: data.imageURL)
            icon.image = data.mealType.image
            timeLabel.text = data.date.toString(.time)
            titleLabel.text = data.title
            descriptionLabel.text = data.description
            dateLabel.text = data.date.toString(.date)
            tagItems = data.tags
            photo.isHidden = data.imageURL == nil
            descriptionLabel.isHidden = data.description == nil
            collectionViewContainer.isHidden = data.tags.isEmpty
            dateLabel.isHidden = screen == .diary
            
            tagsSubject.onNext(data.tags)
        }
    }
    
    private func setupViews() {
        photo.layer.cornerRadius = 2
        photo.layer.masksToBounds = true
        icon.tintColor = .systemTeal
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        collectionView.isUserInteractionEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = createLayout()
        
        tagsSubject
            .map { [TagSection(items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(18))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(18))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(4)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4
        section.contentInsets = .zero
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func updateCollectionViewHeight() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
            if self.collectionViewHeightConstraint.constant != height {
                self.collectionViewHeightConstraint.constant = height
                self.delegate?.rowHeightDidChange(self)
            }
        }
    }
}

extension MealLogCell.TagSection: SectionModelType {
    init(original: MealLogCell.TagSection, items: [String]) {
        self = original
        self.items = items
    }
}
