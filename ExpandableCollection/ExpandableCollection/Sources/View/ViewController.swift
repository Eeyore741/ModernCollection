//
//  ViewController.swift
//  ExpandableCollection
//
//  Created by vitalii.kuznetsov on 2022-05-19.
//

import UIKit

final class ViewController: UIViewController {
    
    private let collectionViewLayout: UICollectionViewLayout
    
    private lazy var listView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewLayout)
        view.register(TextItemCollectionCell.self, forCellWithReuseIdentifier: TextItemCollectionCell.description())
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var textItems: [TextItem] = {
        (1...22).map { TextItem.makeDummy(withPrefix: String($0)) }
    }()
    
    private var collapsedRows: [Int] = (0...21).map { $0 }
    
    init(withCollectionViewLayout layout: UICollectionViewLayout) {
        self.collectionViewLayout = layout
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
