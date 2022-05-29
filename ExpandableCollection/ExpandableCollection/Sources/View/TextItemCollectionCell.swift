//
//  TextItemCollectionCell.swift
//  ExpandableCollection
//
//  Created by vitalii.kuznetsov on 2022-05-29.
//

import UIKit

final class TextItemCollectionCell: UICollectionViewCell {
    
    override class var requiresConstraintBasedLayout: Bool { true }
    
    private var constraintsUpdateOnce: Bool = false
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descrLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
//        label.lineBreakMode = .byTruncatingTail
//        label.lineBreakStrategy = .hangulWordPriority
//        label.allowsDefaultTighteningForTruncation = false
//        label.baselineAdjustment = .alignCenters
//        label.textAlignment = .left
        return label
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var collapseConstraint: NSLayoutConstraint = {
        self.contentView.heightAnchor.constraint(equalToConstant: 66.0)
    }()
    
    private lazy var bottomConstraint: NSLayoutConstraint = {
        self.descrLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
    }()
    
    var textItem: TextItem? {
        didSet {
            self.titleLabel.text = self.textItem?.title
            self.descrLabel.text = self.textItem?.descr
            
            self.setNeedsUpdateConstraints()
            self.updateConstraintsIfNeeded()
        }
    }
    
    func setCollapsed(_ collapsed: Bool, animated: Bool) {
        self.bottomConstraint.isActive = collapsed == false
        let handler = {
            self.collapseConstraint.isActive = collapsed
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        if animated {
            UIView.animate(withDuration: 0.3) { handler() }
        } else {
            handler()
        }
    }
    
    override func updateConstraints() {
        defer { super.updateConstraints() }
        guard self.constraintsUpdateOnce == false else { return }
        self.constraintsUpdateOnce = true
        
        self.line.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.line)
        NSLayoutConstraint.activate([
            self.line.heightAnchor.constraint(equalToConstant: 1.0),
            self.line.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.line.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.line.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.readableContentGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.readableContentGuide.trailingAnchor)
        ])
        
        self.descrLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.descrLabel)
        NSLayoutConstraint.activate([
            self.descrLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.descrLabel.leadingAnchor.constraint(equalTo: self.contentView.readableContentGuide.leadingAnchor),
            self.descrLabel.trailingAnchor.constraint(equalTo: self.contentView.readableContentGuide.trailingAnchor),
            self.bottomConstraint
        ])
        
        self.contentView.backgroundColor = .white
        self.contentView.clipsToBounds = true
        self.collapseConstraint.isActive = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textItem = nil
        self.setCollapsed(true, animated: false)
    }
}
