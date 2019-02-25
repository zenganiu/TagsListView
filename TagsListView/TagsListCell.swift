//
//  TagsListCell.swift
//  TagsListView
//
//  Created by zengnaiu on 2019/2/25.
//  Copyright © 2019 zengnaiu. All rights reserved.
//

import UIKit

protocol TagsListCellDelegate {
    func didTappedDelButton(cell: TagsListCell)
}


class TagsListCell: UICollectionViewCell {
    
    var delegate: TagsListCellDelegate?
    var label: UILabel = {
        
       let lb = UILabel()
       lb.font = UIFont.systemFont(ofSize: 14)
       return lb
        
    }()
    var delButton: UIButton = {
        
       let btn = UIButton()
       btn.setTitle("✕", for: .normal)
       btn.setTitleColor(UIColor.darkGray, for: .normal)
       btn.setTitleColor(UIColor.darkGray.withAlphaComponent(0.7), for: .highlighted)
       return btn
        
    }()
    
    
    override func layoutSubviews() {
                
        delButton.frame = .init(x: frame.width-5-25, y: (frame.height-25)/2, width: 25, height: 25)
        label.frame = .init(x: 10, y: (frame.height-20)/2, width: frame.width-10-5-35, height: 20)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        
        self.addSubview(label)
        self.addSubview(delButton)
        delButton.addTarget(self, action: #selector(delButtonAction), for: .touchUpInside)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func delButtonAction(){
        self.delegate?.didTappedDelButton(cell: self)
    }
    
}
