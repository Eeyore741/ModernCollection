//
//  TextItem.swift
//  ExpandableCollection
//
//  Created by vitalii.kuznetsov on 2022-05-29.
//

import Foundation

struct TextItem {
    
    let title: String
    let descr: String
    
    static func makeDummy(withPrefix: String = "") -> Self {
        let title = String("abcdefghijklmnopqrstuvwxyz".shuffled()).capitalized
        var descr = title
        
        var times = (3...5).randomElement()
        while times != 0 {
            descr += descr
            times? -= 1
        }
        return TextItem(title: withPrefix + ". " + title, descr: descr)
    }
}
