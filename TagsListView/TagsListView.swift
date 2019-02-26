//
//  TagsListView.swift
//  TagsListView
//
//  Created by zengnaiu on 2019/2/25.
//  Copyright © 2019 zengnaiu. All rights reserved.
//

import UIKit

public struct TagConfig{
    
    public enum CellStyle {
        case text  //标签
        case closeText //带删除的标签
    }
    
    //Cell背景颜色
    public var cellBackgroudColor: UIColor = UIColor(displayP3Red: CGFloat(0xCE)/255, green: CGFloat(0x5C)/255, blue: CGFloat(0x4E)/255, alpha: 1)
    
    //背景色
    public var viewBackgroudColor: UIColor = UIColor.groupTableViewBackground
    
    //标签字体颜色
    public var textColor: UIColor = UIColor.white
    
    //标签样式
    public var cellStyle: CellStyle = .text
    
    public init() {}
    
}


public class TagsListView: UIView {
    
    public var dataSource: [String] = []
    
    
    private var collection: UICollectionView!
    private let config: TagConfig
    
    
    public init(config: TagConfig){
        
        self.config = config
        super.init(frame: .zero)
        setupUI()
    }
    
    //初始化
    private func setupUI(){
        
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 10
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(TagsListCell.self, forCellWithReuseIdentifier: "TagsListCell")
        collection.backgroundColor = config.viewBackgroudColor
        self.addSubview(collection)
        
    }
    
    //添加标签
    public func add(tag: String){
        
        dataSource.append(tag)
        collection.performBatchUpdates({
            self.collection.insertItems(at: [IndexPath(row: dataSource.count-1, section: 0)])
        }, completion: nil)
        
    }
    //设置标签初始数据
    public func setDataSource(_ tags: [String]){
        
        UIView.animate(withDuration: 0.3) {
            self.dataSource = tags
            self.collection.reloadData()
        }
    }
    
    override public func layoutSubviews() {
        collection.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension TagsListView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    //MARK:--UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
        
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsListCell", for: indexPath) as! TagsListCell
        cell.delegate = self
        let tag = dataSource[indexPath.row]
        cell.setCell(model: tag, config: config)
        return cell
        
    }
    
    //MARK:--UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        switch config.cellStyle { 
        case .text:
            
            guard indexPath.row < dataSource.count else {return .zero}
            let tag = dataSource[indexPath.row]
            let size = NSString(string: tag).boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 15), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
            return CGSize(width: size.width+20, height: 28)
            
        case .closeText:
            
            guard indexPath.row < dataSource.count else {return .zero}
            let tag = dataSource[indexPath.row]
            let size = NSString(string: tag).boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 15), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
            return CGSize(width: size.width+10+5+10+25, height: 28)
        }
    }
}

extension TagsListView: TagsListCellDelegate{
    
    func didTappedDelButton(cell: TagsListCell) {
        
        guard let index = collection.indexPath(for: cell) else{return}
        self.dataSource.remove(at: index.row)
        collection.performBatchUpdates({
            collection.deleteItems(at: [index])
        }, completion: nil)
        
    }
}
