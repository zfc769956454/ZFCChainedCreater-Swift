
Pod::Spec.new do |s|
s.name = 'ZFCChainedCreater-Swift'
s.version = '1.2.1'
s.license = { :type => "MIT", :file => "LICENSE" }
s.summary = '这是一个将UI的创建转成链式调用，包含UIView、UILabel、UIImageView、UIButton、UITextField、UITextView、UITableView、UICollectionView这些常用控件的创建'


s.homepage = 'https://github.com/zfc769956454/ZFCChainedCreater-Swift'
s.authors = { 'zhaofuheng' => '769956454@qq.com' }
s.source = { :git => 'https://github.com/zfc769956454/ZFCChainedCreater-Swift.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'ChainedCreater/*.swift'
s.swift_version = '4.0'


end
