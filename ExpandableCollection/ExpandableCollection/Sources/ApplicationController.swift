//
//  ApplicationController.swift
//  ExpandableCollection
//
//  Created by vitalii.kuznetsov on 2022-05-29.
//

import UIKit

final class ApplicationController {
    
    func startFromWindow(_ window: UIWindow) {
        let controller = self.makeRootController()
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}

private extension ApplicationController {
    
    func makeRootController() -> UIViewController {
        let layout = self.makeCollectionViewFlowLayout()
        let controller = self.makeCollectionControllerWithLayout(layout)
        
        return controller
    }
    
    func makeCollectionControllerWithLayout(_ layout: UICollectionViewLayout) -> UIViewController {
        let controller = ViewController(withCollectionViewLayout: layout)
        
        return controller
    }
    
    func makeCollectionViewFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        
        return layout
    }
}
