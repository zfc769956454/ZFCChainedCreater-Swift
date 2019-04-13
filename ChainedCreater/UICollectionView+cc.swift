//
//  UICollectionView+cc.swift
//  ChainedDemo-Swift
//
//  Created by 富成赵 on 2019/3/25.
//  Copyright © 2019 前海创石记（深圳）科技有限公司. All rights reserved.
//

import UIKit

//链式创建
public final class ZFC_CollectionViewChainedCreater {
    
    
    public var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    public lazy var chainedCollectionView: UICollectionView = {
        
        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        return collectionView
    }()
    
    @discardableResult
    public func layout_minimumLineSpacing(_ minimumLineSpacing: CGFloat) -> ZFC_CollectionViewChainedCreater {
        
        self.layout.minimumLineSpacing = minimumLineSpacing
        
        return self
    }
    
    @discardableResult
    public func layout_minimumInteritemSpacing(_ minimumInteritemSpacing: CGFloat) -> ZFC_CollectionViewChainedCreater {
        
        self.layout.minimumInteritemSpacing = minimumInteritemSpacing
        
        return self
    }
    
    @discardableResult
    public func layout_itemSize(_ itemSize: CGSize) -> ZFC_CollectionViewChainedCreater {
        
        self.layout.itemSize = itemSize
        
        return self
    }
    
    @discardableResult
    public func layout_estimatedItemSize(_ estimatedItemSize: CGSize) -> ZFC_CollectionViewChainedCreater {
        
        self.layout.estimatedItemSize = estimatedItemSize
        
        return self
    }
    
    @discardableResult
    public func layout_scrollDirection(_ scrollDirection: UICollectionView.ScrollDirection) -> ZFC_CollectionViewChainedCreater {
        
        self.layout.scrollDirection = scrollDirection
        
        return self
    }
    
    @discardableResult
    public func layout_headerReferenceSize(_ headerReferenceSize: CGSize) -> ZFC_CollectionViewChainedCreater {
        
        self.layout.headerReferenceSize = headerReferenceSize
        
        return self
    }
    
    @discardableResult
    public func layout_footerReferenceSize(_ footerReferenceSize: CGSize) -> ZFC_CollectionViewChainedCreater {
        
        self.layout.footerReferenceSize = footerReferenceSize
        
        return self
    }
    
    @discardableResult
    public func frame(_ frame: CGRect) -> ZFC_CollectionViewChainedCreater {
        
        self.chainedCollectionView.frame = frame
        
        return self
    }
    
    @discardableResult
    public func addIntoView(_ superView: UIView) -> ZFC_CollectionViewChainedCreater {
        
        superView.addSubview(self.chainedCollectionView)
        
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ backgroudColor: UIColor) -> ZFC_CollectionViewChainedCreater {
        
        self.chainedCollectionView.backgroundColor = backgroudColor
        
        return self
    }
    
    @discardableResult
    public func tag(_ tag: Int) -> ZFC_CollectionViewChainedCreater {
        
        self.chainedCollectionView.tag = tag
        return self
    }
    
}


extension ChainedCreater where Base: UICollectionView {
    
    @discardableResult
    public static func zfc_collectionViewChainedCreater(_ chainedCreaterBlock: (_ creater: ZFC_CollectionViewChainedCreater) -> ()) -> UICollectionView {
        
        let chainedCreater = ZFC_CollectionViewChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedCollectionView
        
    }
}


/// 链式调用部分
public struct ZFC_CollectionViewChainedInvokeConfig {
    
    public var collectionView: UICollectionView?
    
    public var cellClassArray: [UICollectionViewCell.Type]?
    public var sectionHeaderClassArray: [UICollectionReusableView.Type]?
    public var sectionFooterClassArray: [UICollectionReusableView.Type]?
    
    public init() {}
    
}

public class ZFC_CollectionViewChainedInvoke: NSObject{
    
    private var invokeConfig: ZFC_CollectionViewChainedInvokeConfig?
    
    private var numberOfSectionsInCollectionViewHandle: ((_ collectionView: UICollectionView) -> Int)?
    private var numberOfItemsInSectionHandle: ((_ collectionView: UICollectionView, _ section: Int) -> Int)?
    private var cellForItemAtIndexPathHandle: ((_ collectionView: UICollectionView, _ cellArray: [UICollectionViewCell.Type], _ indexPath: IndexPath) -> UICollectionViewCell)?
    private var sizeForItemAtIndexPathHandle: ((_ collectionView: UICollectionView, _ indexPath: IndexPath) -> CGSize)?
    private var referenceSizeForHeaderInSectionHandle: ((_ collectionView: UICollectionView, _ section: Int) -> CGSize)?
    private var collectionElementKindSectionHeaderHandle: ((_ collectionView: UICollectionView, _ sectionHeaderView: [UICollectionReusableView.Type],_ iindexPath: IndexPath) -> UICollectionReusableView)?
    private var referenceSizeForFooterInSectionHandle: ((_ collectionView: UICollectionView, _ section: Int) -> CGSize)?
    private var collectionElementKindSectionFooterHandle: ((_ collectionView: UICollectionView, _ sectionFooterView: [UICollectionReusableView.Type],_ indexPath: IndexPath) -> UICollectionReusableView)?
    private var didSelectItemAtIndexPathHandle: ((_ collectionView: UICollectionView, _ indexPath: IndexPath) -> ())?
    
    @discardableResult
    public func zfc_collectionViewConfigure(_ invokeConfig: ZFC_CollectionViewChainedInvokeConfig) -> ZFC_CollectionViewChainedInvoke {
        
        self.invokeConfig = invokeConfig
        guard let cellClassArray = invokeConfig.cellClassArray else {
            assert(true, "请传入一个cell的类对象")
            return self
        }
        for cellClass in cellClassArray {
            invokeConfig.collectionView?.register(cellClass, forCellWithReuseIdentifier: "\(cellClass)")
        }
        
        if let sectionHeaderClassArray = invokeConfig.sectionHeaderClassArray {
            for sectionHeaderClass in sectionHeaderClassArray {
                invokeConfig.collectionView?.register(sectionHeaderClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(sectionHeaderClass)")
            }
        }
        
        if let sectionFooterClassArray = invokeConfig.sectionFooterClassArray {
            for sectionFooterClass in sectionFooterClassArray {
                invokeConfig.collectionView?.register(sectionFooterClass, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "\(sectionFooterClass)")
            }
        }
        invokeConfig.collectionView?.delegate = self
        invokeConfig.collectionView?.dataSource = self
        
        return self
    }
    
    @discardableResult
    public func zfc_numberOfSectionsInCollectionView(_ numberOfSectionsInCollectionViewHandle: @escaping(_ collectionView: UICollectionView) -> Int ) -> ZFC_CollectionViewChainedInvoke {
        
        self.numberOfSectionsInCollectionViewHandle = numberOfSectionsInCollectionViewHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_numberOfItemsInSection(_ numberOfItemsInSectionHandle: @escaping(_ collectionView: UICollectionView, _ section: Int) -> Int ) -> ZFC_CollectionViewChainedInvoke {
        
        self.numberOfItemsInSectionHandle = numberOfItemsInSectionHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_cellForItemAtIndexPath(_ cellForItemAtIndexPathHandle: @escaping(_ collectionView: UICollectionView, _ cellArray: [UICollectionViewCell.Type] , _ indexPath: IndexPath) -> UICollectionViewCell ) -> ZFC_CollectionViewChainedInvoke {
        
        self.cellForItemAtIndexPathHandle = cellForItemAtIndexPathHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_sizeForItemAtIndexPath(_ sizeForItemAtIndexPathHandle: @escaping(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> CGSize ) -> ZFC_CollectionViewChainedInvoke {
        
        self.sizeForItemAtIndexPathHandle = sizeForItemAtIndexPathHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_referenceSizeForHeaderInSection(_ referenceSizeForHeaderInSectionHandle: @escaping(_ collectionView: UICollectionView, _ section: Int) -> CGSize ) -> ZFC_CollectionViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionHeaderClassArray ?? []).count > 0, "请传入一个段头的类对象")
        
        self.referenceSizeForHeaderInSectionHandle = referenceSizeForHeaderInSectionHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_collectionElementKindSectionHeader(_ collectionElementKindSectionHeaderHandle: @escaping(_ collectionView: UICollectionView, _ headerView: [UICollectionReusableView.Type],_ indexPath: IndexPath) -> UICollectionReusableView ) -> ZFC_CollectionViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionHeaderClassArray ?? []).count > 0, "请传入一个段头的类对象")
        
        self.collectionElementKindSectionHeaderHandle = collectionElementKindSectionHeaderHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_referenceSizeForFooterInSection(_ referenceSizeForFooterInSectionHandle: @escaping(_ collectionView: UICollectionView, _ section: Int) -> CGSize ) -> ZFC_CollectionViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionFooterClassArray ?? []).count > 0, "请传入一个段尾的类对象")
        
        self.referenceSizeForFooterInSectionHandle = referenceSizeForFooterInSectionHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_collectionElementKindSectionFooter(_ collectionElementKindSectionFooterHandle: @escaping(_ collectionView: UICollectionView, _ footerView: [UICollectionReusableView.Type],_ indexPath: IndexPath) -> UICollectionReusableView ) -> ZFC_CollectionViewChainedInvoke {
        
        assert((self.invokeConfig?.sectionFooterClassArray ?? []).count > 0, "请传入一个段尾的类对象")
        
        self.collectionElementKindSectionFooterHandle = collectionElementKindSectionFooterHandle
        
        return self
    }
    
    @discardableResult
    public func zfc_didSelectItemAtIndexPath(_ didSelectItemAtIndexPathHandle: @escaping(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> () ) -> ZFC_CollectionViewChainedInvoke {
        
        self.didSelectItemAtIndexPathHandle = didSelectItemAtIndexPathHandle
        return self
    }
    
}



// MARK: - UITableViewDataSource,UITableViewDelegate
extension ZFC_CollectionViewChainedInvoke: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSectionsInCollectionViewHandle?(collectionView) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSectionHandle?(collectionView,section) ?? 0
    }
    
   
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let invokeConfig = invokeConfig,
            let cellClassArray = invokeConfig.cellClassArray else {
                return UICollectionViewCell()
        }
       
        let cell = cellForItemAtIndexPathHandle?(collectionView, cellClassArray, indexPath) ?? UICollectionViewCell()
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForItemAtIndexPathHandle?(collectionView,indexPath) ?? CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return referenceSizeForHeaderInSectionHandle?(collectionView, section) ?? CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return referenceSizeForFooterInSectionHandle?(collectionView, section) ?? CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {

            guard let invokeConfig = invokeConfig ,
                let sectionHeaderClassArray = invokeConfig.sectionHeaderClassArray else {
                    return UICollectionReusableView()
            }
          
            let sectionHeaderView = collectionElementKindSectionHeaderHandle?(collectionView, sectionHeaderClassArray, indexPath) ?? UICollectionReusableView()
            
            return sectionHeaderView
        }
        
        guard let invokeConfig = invokeConfig ,
            let sectionFootererClassArray = invokeConfig.sectionFooterClassArray else {
                return UICollectionReusableView()
        }
        
        let sectionFooterView = collectionElementKindSectionFooterHandle?(collectionView, sectionFootererClassArray, indexPath) ?? UICollectionReusableView()
        return sectionFooterView
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        didSelectItemAtIndexPathHandle?(collectionView,indexPath)
    }
  
    
    public func zfc_reloadData() {
        
        self.invokeConfig?.collectionView?.reloadData()
    }
    
    public func zfc_reloadItems(at indexPaths: [IndexPath]) {

        self.invokeConfig?.collectionView?.reloadItems(at: indexPaths)
    }
    
    public func zfc_reloadSections(_ sections: IndexSet) {
        
        self.invokeConfig?.collectionView?.reloadSections(sections)
    }
    
}

extension UICollectionView {
    
    private struct AssociatedKeys {
        static var chainedInvokerKey = "chainedInvokerKey"
    }
    
    public var chainedInvoker: ZFC_CollectionViewChainedInvoke {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.chainedInvokerKey, newValue,  objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.chainedInvokerKey) as! ZFC_CollectionViewChainedInvoke
        }
    }
    
    public func zfc_configCollectionView(_ configure: (_ chainedInvoke: ZFC_CollectionViewChainedInvoke) -> ()) {
        
        let chainedInvoke = ZFC_CollectionViewChainedInvoke()
        
        self.chainedInvoker = chainedInvoke
        
        configure(chainedInvoke)
        
    }
    
}

