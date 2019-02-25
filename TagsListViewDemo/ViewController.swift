//
//  ViewController.swift
//  TagsListViewDemo
//
//  Created by zengnaiu on 2019/2/25.
//  Copyright © 2019 zengnaiu. All rights reserved.
//

import UIKit
import TagsListView


class ViewController: UIViewController {

    var tagsList: TagsListView!
    var tags: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tagsList = TagsListView(config: TagsConfig())
        tagsList.frame = .init(x: 0, y: 64, width: view.frame.width, height: 300)
        self.view.addSubview(tagsList)
        
        tagsList.setDataSource(["1","11","111","1111","11111not been implemented"])
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tag = "\(arc4random()%10000)"
        
        tags.append(tag)
        tagsList.setDataSource(tags)
    }
}

