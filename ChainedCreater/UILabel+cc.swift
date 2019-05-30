//
//  UILabel+cc.swift
//  ChainedDemo-Swift
//
//  Created by 富成赵 on 2019/3/23.
//  Copyright © 2019年 前海创石记（深圳）科技有限公司. All rights reserved.
//

import UIKit

public typealias ZFC_CreaterLabelTapBlock = (_ label: UILabel) -> ()

public final class ZFC_LabelChainedCreater {
    
    private var keepBlock: ZFC_CreaterLabelTapBlock?
    
    fileprivate lazy var chainedLabel: UILabel = {
        
        let label = UILabel()
        return label
    }()
    
    @discardableResult
    public func labelClass(_ labelClass: UILabel.Type) -> ZFC_LabelChainedCreater {
        
        chainedLabel = labelClass.init()
        return self
    }
    
    @discardableResult
    public func addIntoView(_ superView: UIView) -> ZFC_LabelChainedCreater {
        
        superView.addSubview(self.chainedLabel)
        return self
        
    }
    
    @discardableResult
    public func frame(_ frame: CGRect) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.frame = frame
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ backgroudColor: UIColor) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.backgroundColor = backgroudColor
        return self
    }
    
    @discardableResult
    public func text(_ text: String) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.text = text
        return self
    }
    
    @discardableResult
    public func textColor(_ textColor: UIColor) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.textColor = textColor
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.font = font
        return self
    }
    
    @discardableResult
    public func textAlignment(_ textAlignment: NSTextAlignment) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    public func numberOfLines(_ numberOfLines: NSInteger) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.lineBreakMode = lineBreakMode
        return self
    }
    
    @discardableResult
    public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    @discardableResult
    public func tag(_ tag: Int) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.tag = tag
        return self
    }
    
    @discardableResult
    public func layerCornerRadius(_ cornerRadius: CGFloat) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.layer.cornerRadius = cornerRadius
        self.chainedLabel.clipsToBounds = true
        return self
    }
    
    @discardableResult
    public func layerBorderWidthAndBorderColor(_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.layer.borderWidth = borderWidth;
        self.chainedLabel.layer.borderColor = borderColor.cgColor;
        return self
    }
    
    @discardableResult
    public func tapBlock(_ tapBlock: @escaping(ZFC_CreaterLabelTapBlock)) -> ZFC_LabelChainedCreater {
        
        self.chainedLabel.isUserInteractionEnabled = true
        self.keepBlock = tapBlock
        
        return self
    }
    
    init() {
        
        self.chainedLabel.create_tapBlock(byValueBlock: { (label) in
            
            guard let keepBlock = self.keepBlock else {return}
            keepBlock(label)
            
        }, label: self.chainedLabel)
        
    }

}


extension UILabel {
    
    private struct AssociatedKeys {
        static var labelTapKey = "labelTapKey"
    }
    
    fileprivate func create_tapBlock(byValueBlock: ZFC_CreaterLabelTapBlock?, label: UILabel) {
        
        objc_setAssociatedObject(self, &AssociatedKeys.labelTapKey, byValueBlock, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(labelTap))
        label.addGestureRecognizer(tap)
        
    }
    
    @objc func labelTap(tap: UITapGestureRecognizer) {
        
        guard let byValueBlock = (objc_getAssociatedObject(self, &AssociatedKeys.labelTapKey) as? ZFC_CreaterLabelTapBlock) else {return};
        
        byValueBlock(tap.view as! UILabel)
        
    }
}


extension ChainedCreater where Base: UILabel {

    @discardableResult
    public static func zfc_labelChainedCreater(_ chainedCreaterBlock: (_ creater: ZFC_LabelChainedCreater) -> ()) -> UILabel {
        
        let chainedCreater = ZFC_LabelChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedLabel
        
    }
    
}
