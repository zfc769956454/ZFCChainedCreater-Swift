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
    
    @discardableResult
    public func frameAndStyle(_ frame: CGRect, _ style: UITableViewStyle) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView = UITableView(frame: frame, style: style)
        
        return self
        
    }
    
    @discardableResult
    public func addIntoView(_ superView: UIView) -> ZFC_TableViewChainedCreater {
        superView.addSubview(self.chainedTableView)
        
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ backgroudColor: UIColor) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.backgroundColor = backgroudColor
        
        return self
    }
    
    @discardableResult
    public func tag(_ tag: Int) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.tag = tag
        
        return self
    }
    
    
    @discardableResult
    public func separatorStyleAndColor(_ separatorStyle: UITableViewCellSeparatorStyle, _ separatorColor: UIColor) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.separatorStyle = separatorStyle
        if separatorStyle != UITableViewCellSeparatorStyle.none {
            self.chainedTableView.separatorColor = separatorColor
        }
        
        return self
    }
  
    @discardableResult
    public func separatorInset(_ separatorInset: UIEdgeInsets) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.separatorInset = separatorInset
        
        return self
    }
    
    @discardableResult
    public func tableHeaderView(_ tableHeaderView: UIView) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.tableHeaderView = tableHeaderView
        
        return self
    }
    
    @discardableResult
    public func tableFooterView(_ tableFooterView: UIView) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.tableFooterView = tableFooterView
        
        return self
    }
    
    @discardableResult
    public func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: Bool) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        
        return self
    }
    
    @discardableResult
    public func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: Bool) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        
        return self
    }
    
    @discardableResult
    public func rowHeight(_ rowHeight: CGFloat) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.rowHeight = rowHeight
        
        return self
    }
    
    @discardableResult
    public func estimatedRowHeight(_ estimatedRowHeight: CGFloat) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.estimatedRowHeight = estimatedRowHeight
        
        return self
        
    }
    
    @discardableResult
    public func sectionHeaderHeight(_ sectionHeaderHeight: CGFloat) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.sectionHeaderHeight = sectionHeaderHeight
        
        return self
    }
    
    @discardableResult
    public func sectionFooterHeight(_ sectionFooterHeight: CGFloat) -> ZFC_TableViewChainedCreater {
        
        self.chainedTableView.sectionFooterHeight = sectionFooterHeight
        
        return self
    }

}


extension ChainedCreater where Base: UITableView {
    
    @discardableResult
    public static func zfc_tableViewChainedCreater(_ chainedCreaterBlock: (_ creater: ZFC_TableViewChainedCreater) -> ()) -> UITableView {
        
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
    private var cellForRowAtIndexPathHandle: ((_ tableView: UITableView, _ cellArray: [UITableViewCell.Type], _ indexPath: IndexPath) -> UITableViewCell)?
    private var heightForRowAtIndexPathHandle: ((_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat)?
    private var heightForHeaderInSectionHandle: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?
    private var viewForHeaderInSectionHandle: ((_ tableView: UITableView, _ headerView: [UITableViewHeaderFooterView.Type],_ section: Int) -> UITableViewHeaderFooterView)?
    private var heightForFooterInSectionHandle: ((_ tableView: UITableView, _ section: Int) -> CGFloat)?
    private var viewForFooterInSectionHandle: ((_ tableView: UITableView, _ footerView: [UITableViewHeaderFooterView.Type],_ section: Int) -> UITableViewHeaderFooterView)?
    private var deleteCellWithIndexPathHandle: ((_ tableView: UITableView, _ indexPath: IndexPath) -> ())?
    private var didSelectRowAtIndexPathHandle: ((_ tableView: UITableView, _ indexPath: IndexPath) -> ())?
    
    @discardableResult
    public func zfc_tableViewConfigure(_ invokeConfig: ZFC_TableViewChainedInvokeConfig) -> ZFC_TableViewChainedInvoke {
        
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
    
    @discardableResult
    public func zfc_numberOfSectionsInTableView(_ numberOfSectionsInTableViewHandle: @escaping(_ tableView: UITableView) -> Int ) -> ZFC_TableViewChainedInvoke {
        
        self.numberOfSectionsInTableViewHandle = numberOfSectionsInTableViewHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_numberOfRowsInSection(_ numberOfRowsInSectionHandle: @escaping(_ tableView: UITableView, _ section: Int) -> Int ) -> ZFC_TableViewChainedInvoke {
        
        self.numberOfRowsInSectionHandle = numberOfRowsInSectionHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_cellForRowAtIndexPath(_ cellForRowAtIndexPathHandle: @escaping(_ tableView: UITableView, _ cellArray: [UITableViewCell.Type] , _ indexPath: IndexPath) -> UITableViewCell ) -> ZFC_TableViewChainedInvoke {
        
        self.cellForRowAtIndexPathHandle = cellForRowAtIndexPathHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_heightForRowAtIndexPath(_ heightForRowAtIndexPathHandle: @escaping(_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat ) -> ZFC_TableViewChainedInvoke {
        
        self.heightForRowAtIndexPathHandle = heightForRowAtIndexPathHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_heightForHeaderInSection(_ heightForHeaderInSectionHandle: @escaping(_ tableView: UITableView, _ section: Int) -> CGFloat ) -> ZFC_TableViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionHeaderClassArray ?? []).count > 0, "请传入一个段头的类对象")
        
        self.heightForHeaderInSectionHandle = heightForHeaderInSectionHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_viewForHeaderInSection(_ viewForHeaderInSectionHandle: @escaping(_ tableView: UITableView, _ headerView: [UITableViewHeaderFooterView.Type],_ section: Int) -> UITableViewHeaderFooterView ) -> ZFC_TableViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionHeaderClassArray ?? []).count > 0, "请传入一个段头的类对象")
        
        self.viewForHeaderInSectionHandle = viewForHeaderInSectionHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_heightForFooterInSection(_ heightForFooterInSectionHandle: @escaping(_ tableView: UITableView, _ section: Int) -> CGFloat ) -> ZFC_TableViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionFooterClassArray ?? []).count > 0, "请传入一个段尾的类对象")
        
        self.heightForFooterInSectionHandle = heightForFooterInSectionHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_viewForFooterInSection(_ viewForFooterInSectionHandle: @escaping(_ tableView: UITableView, _ footerView: [UITableViewHeaderFooterView.Type],_ section: Int) -> UITableViewHeaderFooterView ) -> ZFC_TableViewChainedInvoke {
    
        assert((self.invokeConfig?.sectionFooterClassArray ?? []).count > 0, "请传入一个段尾的类对象")
        
        self.viewForFooterInSectionHandle = viewForFooterInSectionHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_deleteCellWithIndexPath(_ deleteCellWithIndexPathHandle: @escaping(_ tableView: UITableView, _ indexPath: IndexPath) -> () ) -> ZFC_TableViewChainedInvoke {
        
        self.deleteCellWithIndexPathHandle = deleteCellWithIndexPathHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_didSelectRowAtIndexPath(_ didSelectRowAtIndexPathHandle: @escaping(_ tableView: UITableView, _ indexPath: IndexPath) -> () ) -> ZFC_TableViewChainedInvoke {
        
        self.didSelectRowAtIndexPathHandle = didSelectRowAtIndexPathHandle
        return self
    }

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
        
        guard let invokeConfig = invokeConfig,
            let cellClassArray = invokeConfig.cellClassArray else {
            return UITableViewCell()
        }
        
        let cell = cellForRowAtIndexPathHandle?(tableView, cellClassArray, indexPath) ?? UITableViewCell()

        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return heightForHeaderInSectionHandle?(tableView, section) ?? 0.001
        
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let invokeConfig = invokeConfig ,
            let sectionHeaderClassArray = invokeConfig.sectionHeaderClassArray else {
                return UITableViewHeaderFooterView()
        }
       
        let sectionHeaderView = viewForHeaderInSectionHandle?(tableView,sectionHeaderClassArray,section)
        
        return sectionHeaderView
    }
    
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooterInSectionHandle?(tableView, section) ?? 0.001
    }
    
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let invokeConfig = invokeConfig ,
            let sectionFooterClassArray = invokeConfig.sectionFooterClassArray else {
                return UITableViewHeaderFooterView()
        }
        
        let sectionFooterView = viewForFooterInSectionHandle?(tableView, sectionFooterClassArray,section)
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




