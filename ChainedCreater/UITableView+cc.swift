//
//  UITableView+cc.swift
//  ChainedDemo-Swift
//
//  Created by 富成赵 on 2019/3/23.
//  Copyright © 2019年 前海创石记（深圳）科技有限公司. All rights reserved.
//

import UIKit

//链式创建
public final class ZFC_TableViewChainedCreater {
    
    public var chainedTableView: UITableView = UITableView(frame: .zero, style: .plain)
    
    public var frameAndStyle: (_ frame: CGRect, _ style: UITableViewStyle) -> ZFC_TableViewChainedCreater {
        return { (frame, style) in
        
            self.chainedTableView = UITableView(frame: frame, style: style)
            
            return self
        }
    }
    
    public var addIntoView: (_ superView: UIView) -> ZFC_TableViewChainedCreater {
        return { superView in
            
            superView.addSubview(self.chainedTableView)
            
            return self
            
        }
    }
    
 
    public var backgroundColor: (_ backgroudColor: UIColor) -> ZFC_TableViewChainedCreater {
        
        return { backgroudColor in
            
            self.chainedTableView.backgroundColor = backgroudColor
            
            return self
            
        }
    }
    
    public var tag: (_ tag: Int) -> ZFC_TableViewChainedCreater {
        
        return { tag in
            
            self.chainedTableView.tag = tag
            
            return self
        }
    }
    
    
    public var separatorStyleAndColor: (_ separatorStyle: UITableViewCellSeparatorStyle, _ separatorColor: UIColor) -> ZFC_TableViewChainedCreater {
        
        return { (separatorStyle, separatorColor) in
            
            self.chainedTableView.separatorStyle = separatorStyle
            if separatorStyle != UITableViewCellSeparatorStyle.none {
                self.chainedTableView.separatorColor = separatorColor
            }
            
            return self
            
        }
    }
  
    public var separatorInset: (_ separatorInset: UIEdgeInsets) -> ZFC_TableViewChainedCreater {
        
        return { separatorInset in
            
            self.chainedTableView.separatorInset = separatorInset
            
            return self
        }
    }
    
    public var tableHeaderView: (_ tableHeaderView: UIView) -> ZFC_TableViewChainedCreater {
        
        return { tableHeaderView in
            
            self.chainedTableView.tableHeaderView = tableHeaderView
            
            return self
        }
    }
    
    public var tableFooterView: (_ tableFooterView: UIView) -> ZFC_TableViewChainedCreater {
        
        return { tableFooterView in
            
            self.chainedTableView.tableFooterView = tableFooterView
            
            return self
        }
    }
    
    public var showsVerticalScrollIndicator: (_ showsVerticalScrollIndicator: Bool) -> ZFC_TableViewChainedCreater {
        
        return { showsVerticalScrollIndicator in
            
            self.chainedTableView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
            
            return self
        }
    }
    
    public var showsHorizontalScrollIndicator: (_ showsHorizontalScrollIndicator: Bool) -> ZFC_TableViewChainedCreater {
        
        return { showsHorizontalScrollIndicator in
            
            self.chainedTableView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
            
            return self
        }
    }
    
    public var rowHeight: (_ rowHeight: CGFloat) -> ZFC_TableViewChainedCreater {
        
        return { rowHeight in
            
            self.chainedTableView.rowHeight = rowHeight
            
            return self
        }
    }
    
    
    public var estimatedRowHeight: (_ estimatedRowHeight: CGFloat) -> ZFC_TableViewChainedCreater {
        
        return { estimatedRowHeight in
            
            self.chainedTableView.estimatedRowHeight = estimatedRowHeight
            
            return self
        }
    }
    
    
    public var sectionHeaderHeight: (_ sectionHeaderHeight: CGFloat) -> ZFC_TableViewChainedCreater {
        
        return { sectionHeaderHeight in
            
            self.chainedTableView.sectionHeaderHeight = sectionHeaderHeight
            
            return self
        }
    }
    
    public var sectionFooterHeight: (_ sectionFooterHeight: CGFloat) -> ZFC_TableViewChainedCreater {
        
        return { sectionFooterHeight in
            
            self.chainedTableView.sectionFooterHeight = sectionFooterHeight
            
            return self
        }
    }
    
    public func end() {}
    
    
}


extension ChainedCreater where Base: UITableView {
    
    @discardableResult
    public static func zfc_tableViewChainedCreater(chainedCreaterBlock: @escaping(_ creater: ZFC_TableViewChainedCreater) -> ()) -> UITableView {
        
        let chainedCreater = ZFC_TableViewChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedTableView
        
    }

}



/// 链式调用部分
public struct ZFC_TableViewChainedInvokeConfig {

    public var tableView: UITableView?
    public var isCanDelete = false
    
    public var cellClassArray: [UITableViewCell.Type]?
    public var sectionHeaderClassArray: [UITableViewHeaderFooterView.Type]?
    public var sectionFooterClassArray: [UITableViewHeaderFooterView.Type]?
    
    public init() {}

}

public class ZFC_TableViewChainedInvoke: NSObject{
    
    private var invokeConfig: ZFC_TableViewChainedInvokeConfig?

    private var numberOfSectionsInTableViewHandle: ((_ tableView: UITableView) -> Int)?
    private var numberOfRowsInSectionHandle: ((_ tableView: UITableView, _ section: Int) -> Int)?
    private var cellForRowAtIndexPathHandle: ((_ tableView: UITableView, _ cellArray: [UITableViewCell], _ indexPath: IndexPath) -> UITableViewCell)?
    private var heightForRowAtIndexPathHandle: ((_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat)?
    private var heightForHeaderInSectionHandle: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?
    private var viewForHeaderInSectionHandle: ((_ tableView: UITableView, _ headerView: [UITableViewHeaderFooterView],_ section: Int) -> UITableViewHeaderFooterView)?
    private var heightForFooterInSectionHandle: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?
    private var viewForFooterInSectionHandle: ((_ tableView: UITableView, _ footerView: [UITableViewHeaderFooterView],_ section: Int) -> UITableViewHeaderFooterView)?
    private var deleteCellWithIndexPathHandle: ((_ tableView: UITableView, _ indexPath: IndexPath) -> ())?
    private var didSelectRowAtIndexPathHandle: ((_ tableView: UITableView, _ indexPath: IndexPath) -> ())?
    
    
    public var zfc_tableViewConfigure: (_ invokeConfig: ZFC_TableViewChainedInvokeConfig) -> ZFC_TableViewChainedInvoke {
        
        return { invokeConfig in
            
            self.invokeConfig = invokeConfig
            guard let cellClassArray = invokeConfig.cellClassArray else {
                assert(true, "请传入一个cell的类对象")
                return self
            }
            for cellClass in cellClassArray {
                invokeConfig.tableView?.register(cellClass, forCellReuseIdentifier: "\(cellClass)")
            }
            
            if let sectionHeaderClassArray = invokeConfig.sectionHeaderClassArray {
                for sectionHeaderClass in sectionHeaderClassArray {
                     invokeConfig.tableView?.register(sectionHeaderClass, forHeaderFooterViewReuseIdentifier: "\(sectionHeaderClass)")
                }
            }
            
            if let sectionFooterClassArray = invokeConfig.sectionFooterClassArray {
                for sectionFooterClass in sectionFooterClassArray {
                     invokeConfig.tableView?.register(sectionFooterClass, forHeaderFooterViewReuseIdentifier: "\(sectionFooterClass)")
                }
            }
            invokeConfig.tableView?.delegate = self
            invokeConfig.tableView?.dataSource = self
            
            return self
        }
    }
    
    public var zfc_numberOfSectionsInTableView: (_ numberOfSectionsInTableViewHandle: @escaping(_ tableView: UITableView) -> Int ) -> ZFC_TableViewChainedInvoke {
        
        return { numberOfSectionsInTableViewHandle in
            
            self.numberOfSectionsInTableViewHandle = numberOfSectionsInTableViewHandle
            
            return self
        }
    }
    
    public var zfc_numberOfRowsInSection: (_ numberOfRowsInSectionHandle: @escaping(_ tableView: UITableView, _ section: Int) -> Int ) -> ZFC_TableViewChainedInvoke {
        
        return { numberOfRowsInSectionHandle in
            
            self.numberOfRowsInSectionHandle = numberOfRowsInSectionHandle
            
            return self
        }
    }
    
    
    public var zfc_cellForRowAtIndexPath: (_ cellForRowAtIndexPathHandle: @escaping(_ tableView: UITableView, _ cellArray: [UITableViewCell] , _ indexPath: IndexPath) -> UITableViewCell ) -> ZFC_TableViewChainedInvoke {
        
        return { cellForRowAtIndexPathHandle in
            
            self.cellForRowAtIndexPathHandle = cellForRowAtIndexPathHandle
            
            return self
        }
    }
    
    public var zfc_heightForRowAtIndexPath: (_ heightForRowAtIndexPathHandle: @escaping(_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat ) -> ZFC_TableViewChainedInvoke {
        
        return { heightForRowAtIndexPathHandle in
            
            self.heightForRowAtIndexPathHandle = heightForRowAtIndexPathHandle
            
            return self
        }
    }
    
    public var zfc_heightForHeaderInSection: (_ heightForHeaderInSectionHandle: @escaping(_ tableView: UITableView, _ section: Int) -> CGFloat ) -> ZFC_TableViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionHeaderClassArray ?? []).count > 0, "请传入一个段头的类对象")
        
        return { heightForHeaderInSectionHandle in
            
            self.heightForHeaderInSectionHandle = heightForHeaderInSectionHandle
            
            return self
        }
    }
    
    public var zfc_viewForHeaderInSection: (_ viewForHeaderInSectionHandle: @escaping(_ tableView: UITableView, _ headerView: [UITableViewHeaderFooterView],_ section: Int) -> UITableViewHeaderFooterView ) -> ZFC_TableViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionHeaderClassArray ?? []).count > 0, "请传入一个段头的类对象")
        
        return { viewForHeaderInSectionHandle in
            
            self.viewForHeaderInSectionHandle = viewForHeaderInSectionHandle
            
            return self
        }
    }
    
    public var zfc_heightForFooterInSection: (_ heightForFooterInSectionHandle: @escaping(_ tableView: UITableView, _ section: Int) -> CGFloat ) -> ZFC_TableViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionFooterClassArray ?? []).count > 0, "请传入一个段尾的类对象")
        
        return { heightForFooterInSectionHandle in
            
            self.heightForFooterInSectionHandle = heightForFooterInSectionHandle
            
            return self
        }
    }
    
    public var zfc_viewForFooterInSection: (_ viewForFooterInSectionHandle: @escaping(_ tableView: UITableView, _ footerView: [UITableViewHeaderFooterView],_ section: Int) -> UITableViewHeaderFooterView ) -> ZFC_TableViewChainedInvoke {
    
        assert((self.invokeConfig?.sectionFooterClassArray ?? []).count > 0, "请传入一个段尾的类对象")
        
        return { viewForFooterInSectionHandle in
            
            self.viewForFooterInSectionHandle = viewForFooterInSectionHandle
            
            return self
        }
    }
    
    public var zfc_deleteCellWithIndexPath: (_ deleteCellWithIndexPathHandle: @escaping(_ tableView: UITableView, _ indexPath: IndexPath) -> () ) -> ZFC_TableViewChainedInvoke {
        
        return { deleteCellWithIndexPathHandle in
            
            self.deleteCellWithIndexPathHandle = deleteCellWithIndexPathHandle
            
            return self
        }
    }
    
    public var zfc_didSelectRowAtIndexPath: (_ didSelectRowAtIndexPathHandle: @escaping(_ tableView: UITableView, _ indexPath: IndexPath) -> () ) -> ZFC_TableViewChainedInvoke {
        
        return { didSelectRowAtIndexPathHandle in
            
            self.didSelectRowAtIndexPathHandle = didSelectRowAtIndexPathHandle
                        return self
        }
    }
    
    public func end() {}
    
}



// MARK: - UITableViewDataSource,UITableViewDelegate
extension ZFC_TableViewChainedInvoke: UITableViewDataSource,UITableViewDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfSectionsInTableViewHandle?(tableView) ?? 0
  
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return numberOfRowsInSectionHandle?(tableView, section) ?? 0
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return heightForRowAtIndexPathHandle?(tableView, indexPath) ?? 0
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellArray = [UITableViewCell]()
        guard let invokeConfig = invokeConfig,
            let cellClassArray = invokeConfig.cellClassArray else {
            return UITableViewCell()
        }
        for cellClass in cellClassArray {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(cellClass)") {
                cellArray.append(cell)
            }
        }

        let cell = cellForRowAtIndexPathHandle?(tableView, cellArray, indexPath) ?? UITableViewCell()

        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return heightForHeaderInSectionHandle?(tableView, section) ?? 0.001
        
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var sectionHeaderViewArray = [UITableViewHeaderFooterView]()
        guard let invokeConfig = invokeConfig ,
            let sectionHeaderClassArray = invokeConfig.sectionHeaderClassArray else {
                return UITableViewHeaderFooterView()
        }
        for sectionHeaderClass in sectionHeaderClassArray {
            if let sectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(sectionHeaderClass)") {
                sectionHeaderViewArray.append(sectionHeaderView)
            }
        }
    
        let sectionHeaderView = viewForHeaderInSectionHandle?(tableView,sectionHeaderViewArray,section)
        
        return sectionHeaderView
    }
    
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooterInSectionHandle?(tableView, section) ?? 0.001
    }
    
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        var sectionFooterViewArray = [UITableViewHeaderFooterView]()
        guard let invokeConfig = invokeConfig ,
            let sectionFooterClassArray = invokeConfig.sectionFooterClassArray else {
                return UITableViewHeaderFooterView()
        }
        for sectionFooterClass in sectionFooterClassArray {
            if let sectionFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(sectionFooterClass)") {
                sectionFooterViewArray.append(sectionFooterView)
            }
        }
        
        let sectionFooterView = viewForFooterInSectionHandle?(tableView, sectionFooterViewArray,section)
        return sectionFooterView
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPathHandle?(tableView, indexPath)
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.invokeConfig?.isCanDelete ?? false
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            deleteCellWithIndexPathHandle?(tableView, indexPath)
        }
    }
    
    public func zfc_reloadData() {
        
        self.invokeConfig?.tableView?.reloadData()
    }
    
    public func zfc_reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        
        self.invokeConfig?.tableView?.reloadRows(at: indexPaths, with: animation)
       
    }
    
    public func zfc_reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        
         self.invokeConfig?.tableView?.reloadSections(sections, with: animation)
    }
}


extension UITableView {

    private struct AssociatedKeys {
        static var chainedInvokerKey = "chainedInvokerKey"
    }
    
    public var chainedInvoker: ZFC_TableViewChainedInvoke {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.chainedInvokerKey, newValue,  objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.chainedInvokerKey) as! ZFC_TableViewChainedInvoke
        }
    }

    public func zfc_configTableView(configure: (_ chainedInvoke: ZFC_TableViewChainedInvoke) -> ()) {

        let chainedInvoke = ZFC_TableViewChainedInvoke()

        self.chainedInvoker = chainedInvoke

        configure(chainedInvoke)

    }
}




