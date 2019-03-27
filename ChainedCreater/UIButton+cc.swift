//
//  UIButton+cc.swift
//  ChainedDemo-Swift
//
//  Created by 富成赵 on 2019/3/23.
//  Copyright © 2019年 前海创石记（深圳）科技有限公司. All rights reserved.
//

import UIKit


public typealias ZFC_CreaterButtonActionBlock = (_ button: UIButton) -> ()

public final class ZFC_ButtonChainedCreater {
    
    private var keepBlock: ZFC_CreaterButtonActionBlock?
    
    public lazy var chainedButton: UIButton = {
        
        let button = UIButton()
        return button
        
    }()
    
    
    public var addIntoView: (_ superView: UIView) -> ZFC_ButtonChainedCreater {
        return { superView in
            
            superView.addSubview(self.chainedButton)
            
            return self
            
        }
    }
    
    
    public var frame: (_ frame: CGRect) -> ZFC_ButtonChainedCreater {
        
        return { frame in
            
            self.chainedButton.frame = frame
            
            return self
            
        }
    }
    
    public var backgroundColor: (_ backgroudColor: UIColor) -> ZFC_ButtonChainedCreater {
        
        return { backgroudColor in
            
            self.chainedButton.backgroundColor = backgroudColor
            
            return self
            
        }
    }
    
    
    public var title: (_ title: String, _ state: UIControl.State) -> ZFC_ButtonChainedCreater {
        
        return { (title, state) in
            
            self.chainedButton.setTitle(title, for: state)
            
            return self
            
        }
    }
    
    public var image: (_ image: UIImage, _ state: UIControl.State) -> ZFC_ButtonChainedCreater {
        
        return { (image, state) in
            
            self.chainedButton.setImage(image, for: state)
            
            return self
            
        }
    }
    
    public var titleColor: (_ titleColor: UIColor, _ state: UIControl.State) -> ZFC_ButtonChainedCreater {
        
        return { (titleColor, state) in
            
            self.chainedButton.setTitleColor(titleColor, for: state)
            
            return self
            
        }
    }
    
    public var titleLabelFont: (_ font: UIFont) -> ZFC_ButtonChainedCreater {
        
        return { font in
            
            self.chainedButton.titleLabel?.font = font
            
            return self
        }
    }
    

    public var tag: (_ tag: Int) -> ZFC_ButtonChainedCreater {
        
        return { tag in
            
            self.chainedButton.tag = tag
            
            return self
        }
    }
    
    
    public var layerCornerRadius: (_ cornerRadius: CGFloat) -> ZFC_ButtonChainedCreater {
        
        return { cornerRadius in
            
            self.chainedButton.layer.cornerRadius = cornerRadius
            self.chainedButton.clipsToBounds = true
            
            return self
        }
    }
    
    
    public var contentMode: (_ contentMode: UIView.ContentMode) -> ZFC_ButtonChainedCreater {
        
        return { contentMode in
            
            self.chainedButton.contentMode = contentMode
            
            return self
        }
    }
    
    
    public var layerBorderWidthAndBorderColor: (_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_ButtonChainedCreater {
        
        return { (borderWidth,borderColor) in
            
            self.chainedButton.layer.borderWidth = borderWidth;
            self.chainedButton.layer.borderColor = borderColor.cgColor;
            
            return self
        }
    }
    
    
    public var actionBlock: (_ actionBlock: @escaping(ZFC_CreaterButtonActionBlock)) -> ZFC_ButtonChainedCreater {
        
        return { actionBlock in
        
            self.keepBlock = actionBlock
            return self
        }
    }
    
    public func end() {}
    
    init() {
        
        self.chainedButton.create_actionBlock(byValueBlock: { (button) in
            
            guard let keepBlock = self.keepBlock else {return}
            keepBlock(button)
            
        }, button: self.chainedButton)
        
    }
    
}


extension UIButton {
    
    private struct AssociatedKeys {
        static var buttonActionKey = "buttonActionKey"
    }
    
    fileprivate func create_actionBlock(byValueBlock: ZFC_CreaterButtonActionBlock?, button: UIButton) {
        
        objc_setAssociatedObject(self, &AssociatedKeys.buttonActionKey, byValueBlock, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        addTarget(self, action: #selector(buttonClickAction), for: .touchUpInside)
        
    }
    
    
    @objc func buttonClickAction(button: UIButton) {
        
        guard let byValueBlock = (objc_getAssociatedObject(self, &AssociatedKeys.buttonActionKey) as? ZFC_CreaterButtonActionBlock) else {return};
        
        byValueBlock(button)
        
    }
    
}



extension ChainedCreater where Base: UIButton {
    
    @discardableResult
    public static func zfc_buttonChainedCreater(chainedCreaterBlock: @escaping(_ creater: ZFC_ButtonChainedCreater) -> ()) -> UIButton {
        
        let chainedCreater = ZFC_ButtonChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedButton
        
    }
}


