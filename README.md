# TagsListView
# 支持添加、删除单个标签
![效果图](https://github.com/zenganiu/TagsListView/blob/master/TagsListViewDemo/demo_2.gif)
# 使用
...

        var config = TagConfig() //配置
        config.cellStyle = .closeText //带删除tag
        
        let tagsList = TagsListView(config: config) //初始化
        tagsList.frame = .init(x: 0, y: 0, width: view.frame.width, height: 250) //布局，也支持autolayout
        container.addSubview(tagsList)
        
        tagsList.setDataSource(["土豪"]) //设置标签个数，一般当初始化使用
        
        
        //添加标签
        tagsList.add(tag: "程序员")
        
...
