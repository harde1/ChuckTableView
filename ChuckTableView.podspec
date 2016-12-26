
Pod::Spec.new do |s|


  s.name         = "ChuckTableView"
  s.version      = "0.1.2"
  s.summary      = "高度封装tableView简化cell的操作，与UIViewController解耦"
  s.description  = "

  高度封装tableView\collectionView，简化操作，目的是为了cell可以自由同时存在于不同的UIViewController之中，cell自给自足，cell环境封闭起来

1、容易操作的cell增删改查

2、滚到最后

3、可以自定义的上拉加载更多

4、编辑模式随意添加，随意插入各种cell

5、cell与tableView解耦，与UIViewController解耦

更新了UIcollectionView的操作

                   "

  s.homepage     = "https://github.com/harde1/ChuckTableView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "harde1" => "harde1@163.com" }
   s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/harde1/ChuckTableView.git", :tag => s.version.to_s }
  s.source_files  = "ChuckTableViewLib/*.{h,m}"
 

  s.framework  = "UIKit"
  # s.frameworks = "SomeFramework", "AnotherFramework"

 s.requires_arc = true


end
