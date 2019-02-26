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

    
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    
    var tagsList1: TagsListView!
    var tagsList2: TagsListView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        var config1 = TagConfig()
        config1.cellStyle = .closeText
        tagsList1 = TagsListView(config: config1)
        tagsList1.frame = .init(x: 0, y: 0, width: view.frame.width, height: 250)
        container1.addSubview(tagsList1)
        tagsList1.setDataSource(["土豪"])
        
        
        
        var config2 = TagConfig()
        config2.cellStyle = .text
        tagsList2 = TagsListView(config: config2)
        tagsList2.frame = .init(x: 0, y: 0, width: view.frame.width, height: 250)
        container2.addSubview(tagsList2)
        tagsList2.setDataSource(["牛逼"])
        
        
    }

    
    @IBAction func add1(_ sender: UIButton) {
        
        let str = "我醉欲眠卿且去明朝有意抱琴来"
        
        
        let offset = Int(arc4random()%UInt32(str.count-1))+1
        let tag = str.prefix(upTo: str.index(str.startIndex, offsetBy: offset))
        
        tagsList1.add(tag: String(tag))
        
    }
    
    @IBAction func add2(_ sender: UIButton) {
        
        let str = "我醉欲眠卿且去明朝有意抱琴来"
        
        
        let offset = Int(arc4random()%UInt32(str.count-1))+1
        let tag = str.prefix(upTo: str.index(str.startIndex, offsetBy: offset))
        
        tagsList2.add(tag: String(tag))
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        
        tagsList2.setDataSource([])
    }
    
    
    
}

