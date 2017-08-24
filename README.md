# QTabView

标签页，可以用于新闻的界面、有不同分类的界面等。

##### 运行效果图
![运行效果图](https://github.com/hqs5678/qtabs-swift/blob/master/2017-08-24%2017_35_32.gif)

### 实现原理
封装QHorizontalTableView，添加界面切换的过度动画。

> QHorizontalTableView是封装的UICollectionView，实现简单的水平表格布局，可单独用于其他项目。例如：
> 
> pod 'QHorizontalTableView'
> 
> 项目地址：http://git.oschina.net/hqs.com/horizontaltableview-swift

### 安装说明
### CocoaPods
```
      source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do

pod 'QHorizontalTableView'

end
```

 
#### 使用方法

核心代码如下：

```

tabs = QTabView(frame: self.view.frame)
self.view.addSubview(tabs)

let blue = UIColor(hexString: "1c50f6")
// 设置指示器颜色
tabs.indicatorColor = blue
// 设置正常状态下标题的颜色
tabs.titleNormalColor = UIColor.darkGray
// 设置选中状态下标题的颜色
tabs.titleSelectedColor = blue
// 设置指示器的高度
tabs.indicatorHeight = 2
// 设置标题的背景颜色
tabs.titleBackgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

// 自动布局，设置在父控件中的位置
tabs.layoutInSuperview(20, 0, 0, 0)

// 设置标题
tabs.titles = ["推荐", "娱乐明星", "体育", "新热点", "新闻", "帅哥", "美女", "娱乐明星", "体育", "新热点", "新闻", "帅哥", "美女"]

// 模拟每个标签页的内容
for i in 0 ..< tabs.titles.count {
    let vc = VC1()
    vc.index = "\(tabs.titles[i]) \(i)"
    
    // 已addChildViewController 的方式设置标签页内容
    self.addChildViewController(vc)
}

```

### 注意
==tabs.titles.count== 要和 ==self.childViewControllers.count== 一致！！！


如有其他问题， 请下载运行项目，参考示例代码（Demo分支）。
