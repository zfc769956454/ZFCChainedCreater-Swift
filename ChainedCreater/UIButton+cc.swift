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
    
    @discardableResult
    public func addIntoView(_ superView: UIView) -> ZFC_ButtonChainedCreater {
        superView.addSubview(self.chainedButton)
        
        return self
    }
    
    @discardableResult
    public func frame(_ frame: CGRect) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.frame = frame
        
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ backgroudColor: UIColor) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.backgroundColor = backgroudColor
        
        return self
    }
    
    @discardableResult
    public func title(_ title: String, _ state: UIControl.State) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.setTitle(title, for: state)
        
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage, _ state: UIControl.State) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.setImage(image, for: state)
        
        return self
    }
    
    @discardableResult
    public func titleColor(_ titleColor: UIColor, _ state: UIControl.State) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.setTitleColor(titleColor, for: state)
        
        return self
    }
    
    @discardableResult
    public func titleLabelFont(_ font: UIFont) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.titleLabel?.font = font
        
        return self
    }
    
    @discardableResult
    public func tag(_ tag: Int) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.tag = tag
        
        return self
    }
    
    @discardableResult
    public func layerCornerRadius(_ cornerRadius: CGFloat) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.layer.cornerRadius = cornerRadius
        self.chainedButton.clipsToBounds = true
        
        return self
    }
    
    @discardableResult
    public func contentMode(_ contentMode: UIView.ContentMode) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.contentMode = contentMode
        
        return self
    }
    
    @discardableResult
    public func layerBorderWidthAndBorderColor(_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_ButtonChainedCreater {
        
        self.chainedButton.layer.borderWidth = borderWidth;
        self.chainedButton.layer.borderColor = borderColor.cgColor;
        
        return self
    }
    
    @discardableResult
    public func actionBlock(_ actionBlock: @escaping(ZFC_CreaterButtonActionBlock)) -> ZFC_ButtonChainedCreater {
        
        self.keepBlock = actionBlock
        return self
    }
    
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
    public static func zfc_buttonChainedCreater(_ chainedCreaterBlock: (_ creater: ZFC_ButtonChainedCreater) -> ()) -> UIButton {
        
        let chainedCreater = ZFC_ButtonChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedButton
        
    }
}


