//
//  ViewController.swift
//  ExpandableCollection
//
//  Created by vitalii.kuznetsov on 2022-05-19.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var listView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.register(TextItemCollectionCell.self, forCellWithReuseIdentifier: TextItemCollectionCell.description())
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var textItems: [TextItem] = {
        (1...22).map { _ in TextItem.makeDummy() }
    }()
    
    private var collapsedRows: [Int] = (0...21).map { $0 }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.listView)
        
        NSLayoutConstraint.activate([
            self.listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        self.listView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        22
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextItemCollectionCell.description(), for: indexPath) as? TextItemCollectionCell else { fatalError() }
        
        cell.textItem = self.textItems[indexPath.row]
        cell.setCollapsed(self.collapsedRows.contains(indexPath.row), animated: false)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.collapsedRows.contains(indexPath.row) {
            self.collapsedRows.removeAll { $0 == indexPath.row }
            (collectionView.cellForItem(at: indexPath) as? TextItemCollectionCell)?.setCollapsed(false, animated: true)
        } else {
            self.collapsedRows.append(indexPath.row)
            (collectionView.cellForItem(at: indexPath) as? TextItemCollectionCell)?.setCollapsed(true, animated: true)
        }
        collectionView.performBatchUpdates { }
        
//        collectionView.collectionViewLayout.invalidateLayout()
//        UIView.animate(withDuration: 0.3) {
//            collectionView.layoutIfNeeded()
//        }
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = TextItemCollectionCell()
//        cell.textItem = self.textItems[indexPath.row]
//        let size = cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: UILayoutPriority.fittingSizeLevel, verticalFittingPriority: UILayoutPriority.required)
//        return size
//    }
}
