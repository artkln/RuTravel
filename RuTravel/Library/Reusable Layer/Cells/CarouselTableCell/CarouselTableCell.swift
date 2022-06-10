//
//  CarouselTableCell.swift
//  RuTravel
//
//  Created by kalinin on 06.05.2022.
//

import UIKit

final class CarouselTableCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let cellNibName: String = "CarouselCell"
    }

    // MARK: - Subviews

    @IBOutlet private weak var carouselCollectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!

    // MARK: - Static Properties

    static let cellId: String = "CarouselTableCell"

    // MARK: - Private Properties

    private var model: CarouselTableCellModel?
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }

    // MARK: - UITableViewCell

    override func layoutSubviews() {
        super.layoutSubviews()
        configureAppearance()
    }

    // MARK: - InfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? CarouselTableCellModel else {
            fatalError("Unable to cast model as CarouselTableCellModel: \(model)")
        }

        self.model = model
        pageControl.numberOfPages = model.pictures.count
        carouselCollectionView.reloadData()
    }

    // MARK: - Private Methods

    private func getCurrentPage() -> Int {
        let visibleRect = CGRect(
            origin: carouselCollectionView.contentOffset,
            size: carouselCollectionView.bounds.size
        )
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }

}

// MARK: - UICollectionViewDataSource

extension CarouselTableCell: UICollectionViewDataSource {

   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }

   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       guard let model = model else {
           return 0
       }

       return model.pictures.count
   }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = model else {
            return UICollectionViewCell()
        }

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselCell.cellId,
            for: indexPath
        ) as? CarouselCell else {
            return UICollectionViewCell()
        }

        let image = model.pictures[indexPath.row]

        cell.configure(with: image)

        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension CarouselTableCell: UICollectionViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }

}

// MARK: - Appearance

private extension CarouselTableCell {

    func configureAppearance() {
        configureCollectionView()
        configurePageControl()
    }

    func configureCollectionView() {
        let cellWidth = frame.width / 1.1
        let cellHeight = frame.width / 2
        let minimumLineSpacing = frame.width - cellWidth

        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: cellWidth, height: cellHeight)
        carouselLayout.minimumLineSpacing = minimumLineSpacing
        carouselLayout.sectionInset = .init(
                                        top: 0,
                                        left: minimumLineSpacing / 2,
                                        bottom: 0,
                                        right: minimumLineSpacing / 2
        )
        carouselCollectionView.collectionViewLayout = carouselLayout

        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.isPagingEnabled = true
        carouselCollectionView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellWithReuseIdentifier: CarouselCell.cellId
        )
    }

    func configurePageControl() {
        pageControl.pageIndicatorTintColor = ColorName.gray.color
        pageControl.currentPageIndicatorTintColor = ColorName.blue.color
    }

}
