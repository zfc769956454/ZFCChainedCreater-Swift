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
    
    public lazy var chainedLabel: UILabel = {
        
        let label = UILabel()
        return label
        
    }()
    
    
    public var addIntoView: (_ superView: UIView) -> ZFC_LabelChainedCreater {
        return { superView in
            
            superView.addSubview(self.chainedLabel)
            return self
            
        }
    }
    
    
    public var frame: (_ frame: CGRect) -> ZFC_LabelChainedCreater {
        
        return { frame in
            
            self.chainedLabel.frame = frame
            return self
            
        }
    }
    
    public var backgroundColor: (_ backgroudColor: UIColor) -> ZFC_LabelChainedCreater {
        
        return { backgroudColor in
            
            self.chainedLabel.backgroundColor = backgroudColor
            return self
            
        }
    }
    
    public var text: (_ text: String) -> ZFC_LabelChainedCreater {
        
        return { text in
            
            self.chainedLabel.text = text
            return self
            
        }
    }
    
    public var textColor: (_ textColor: UIColor) -> ZFC_LabelChainedCreater {
        
        return { textColor in
            
            self.chainedLabel.textColor = textColor
            return self
        }
    }
    
    public var font: (_ font: UIFont) -> ZFC_LabelChainedCreater {
        
        return { font in
            
            self.chainedLabel.font = font
            return self
        }
    }
    
    public var textAlignment: (_ textAlignment: NSTextAlignment) -> ZFC_LabelChainedCreater {
        
        return { textAlignment in
            
            self.chainedLabel.textAlignment = textAlignment
            return self
        }
    }
    
    public var numberOfLines: (_ numberOfLines: NSInteger) -> ZFC_LabelChainedCreater {
        
        return { numberOfLines in
            
            self.chainedLabel.numberOfLines = numberOfLines
            return self
        }
    }
    
    public var lineBreakMode: (_ lineBreakMode: NSLineBreakMode) -> ZFC_LabelChainedCreater {
        
        return { lineBreakMode in
            
            self.chainedLabel.lineBreakMode = lineBreakMode
            return self
        }
    }
    
    public var isUserInteractionEnabled: (_ isUserInteractionEnabled: Bool) -> ZFC_LabelChainedCreater {
        
        return { isUserInteractionEnabled in
            
            self.chainedLabel.isUserInteractionEnabled = isUserInteractionEnabled
            return self
        }
    }
    
    public var tag: (_ tag: Int) -> ZFC_LabelChainedCreater {
        
        return { tag in
            
            self.chainedLabel.tag = tag
            return self
        }
    }
    
    public var layerCornerRadius: (_ cornerRadius: CGFloat) -> ZFC_LabelChainedCreater {
        
        return { cornerRadius in
            
            self.chainedLabel.layer.cornerRadius = cornerRadius
            self.chainedLabel.clipsToBounds = true
            return self
        }
    }
    
    public var layerBorderWidthAndBorderColor: (_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_LabelChainedCreater {
        
        return { (borderWidth,borderColor) in
            
            self.chainedLabel.layer.borderWidth = borderWidth;
            self.chainedLabel.layer.borderColor = borderColor.cgColor;
            return self
        }
    }
    

    public var tapBlock: (_ tapBlock: @escaping(ZFC_CreaterLabelTapBlock)) -> ZFC_LabelChainedCreater {
        
        return { tapBlock in
            
            self.chainedLabel.isUserInteractionEnabled = true
            self.keepBlock = tapBlock
            
            return self
        }
    }
    
    public func end() {}
    
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
    public static func zfc_labelChainedCreater(chainedCreaterBlock: @escaping(_ creater: ZFC_LabelChainedCreater) -> ()) -> UILabel {
        
        let chainedCreater = ZFC_LabelChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedLabel
        
    }
    
}
