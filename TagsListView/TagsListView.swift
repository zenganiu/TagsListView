//
//  TagsListView.swift
//  TagsListView
//
//  Created by zengnaiu on 2019/2/25.
//  Copyright © 2019 zengnaiu. All rights reserved.
//

import UIKit

public struct TagsConfig{
    
    public var tagBackGroudColor: UIColor = UIColor.groupTableViewBackground
    public var tagTitleColor: UIColor = UIColor.darkText
    
    public init() {}
}


public class TagsListView: UIView {
    
    
    public var tags: [String] = []
    private var collection: UICollectionView!
    private let config: TagsConfig
    
    public init(config: TagsConfig){
        
        self.config = config
        super.init(frame: .zero)
        setupUI()
        
    }

    private func setupUI(){
        
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 10
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(TagsListCell.self, forCellWithReuseIdentifier: "TagsListCell")
        collection.backgroundColor = UIColor.white
        self.addSubview(collection)
        
    }
    
    
    
    public func setDataSource(_ tags: [String]){
        
        UIView.animate(withDuration: 0.3) {
            self.tags = tags
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


extension TagsListView: UICollectionViewDataSource{
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tags.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsListCell", for: indexPath) as! TagsListCell
        
        let tag = tags[indexPath.row]
        cell.backgroundColor = config.tagBackGroudColor
        cell.label.textColor = config.tagTitleColor
        cell.label.text = tag
        cell.delegate = self
        
        return cell
        
    }
}


extension TagsListView: TagsListCellDelegate{
    
    func didTappedDelButton(cell: TagsListCell) {
        
        guard let index = collection.indexPath(for: cell) else{return}
        self.tags.remove(at: index.row)
        collection.performBatchUpdates({
            collection.deleteItems(at: [index])
        }, completion: nil)
        
    }
}


extension TagsListView: UICollectionViewDelegate{
    
    
}



extension TagsListView: UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = tags[indexPath.row]
        let size = NSString(string: tag).boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 15), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        
        print(size,CGSize(width: size.width+10+5+10+25, height: 28))
        return CGSize(width: size.width+10+5+10+25, height: 28)
         
    }
    
}
