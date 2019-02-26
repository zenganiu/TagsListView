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
    
    
    var cellConfig: TagConfig = TagConfig()
    var delegate: TagsListCellDelegate?
    
    lazy var label: UILabel = {
        
       let lb = UILabel()
       lb.font = UIFont.systemFont(ofSize: 14)
       lb.textAlignment = .center
       return lb
        
    }()
    lazy var delButton: UIButton = {
        
       let btn = UIButton()
       btn.setTitle("✕", for: .normal)
       btn.setTitleColor(UIColor.darkGray, for: .normal)
       btn.setTitleColor(UIColor.darkGray.withAlphaComponent(0.7), for: .highlighted)
       return btn
        
    }()
    lazy var addButton: UIButton = {
       let btn = UIButton(type: UIButton.ButtonType.contactAdd)
       return btn
    }()
    
    internal func setCell(model: String,config: TagConfig){
        
        self.cellConfig = config
        self.subviews.forEach{$0.removeFromSuperview()}
        
        switch cellConfig.cellStyle {
        case .text:
            self.addSubview(label)
            label.text = model
            label.textColor = config.textColor
            
        case .closeText:
            
            self.addSubview(label)
            self.addSubview(delButton)
            
            label.text = model
            label.textColor = config.textColor
            
            delButton.setTitleColor(config.textColor, for: .normal)
            delButton.setTitleColor(config.textColor.withAlphaComponent(0.8), for: .highlighted)
            delButton.addTarget(self, action: #selector(delButtonAction), for: .touchUpInside)
        }
        
        self.backgroundColor = config.cellBackgroudColor
        self.setNeedsLayout()
    }

    override func layoutSubviews() {
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        switch cellConfig.cellStyle {
        case .text:
            label.frame = .init(x: 10, y: (frame.height-20)/2, width: frame.width-20, height: 20)
        case .closeText:
            delButton.frame = .init(x: frame.width-5-25, y: (frame.height-25)/2, width: 25, height: 25)
            label.frame = .init(x: 10, y: (frame.height-20)/2, width: frame.width-10-5-35, height: 20)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func delButtonAction(){
        
        self.delegate?.didTappedDelButton(cell: self)
    }
}
