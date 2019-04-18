//
//  UITextView+cc.swift
//  ChainedDemo-Swift
//
//  Created by 富成赵 on 2019/3/23.
//  Copyright © 2019年 前海创石记（深圳）科技有限公司. All rights reserved.
//

import UIKit

public final class ZFC_TextViewChainedCreater {
    
    public lazy var chainedTextView: UITextView = {
        
        let textView = UITextView()
        return textView
        
    }()
    
    @discardableResult
    public func addIntoView(_ superView: UIView) -> ZFC_TextViewChainedCreater {
        superView.addSubview(self.chainedTextView)
        return self
    }
    
    @discardableResult
    public func frame(_ frame: CGRect) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.frame = frame
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ backgroudColor: UIColor) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.backgroundColor = backgroudColor
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.font = font
        return self
    }
    
    @discardableResult
    public func tag(_ tag: Int) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.tag = tag
        return self
    }
    
    @discardableResult
    public func text(_ text: String) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.text = text
        return self
    }
    
    @discardableResult
    public func textColor(_ textColor: UIColor) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.textColor = textColor
        return self
    }
    
    @discardableResult
    public func textAlignment(_ textAlignment: NSTextAlignment) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    public func placeholder(_ placeholder: String) -> ZFC_TextViewChainedCreater {

        self.chainedTextView.placeholder = placeholder
        return self
    }
    
    @discardableResult
    public func placeholderColor(_ placeholderColor: UIColor) -> ZFC_TextViewChainedCreater {
        
        assert(self.chainedTextView.placeholder.count > 0, "请先设置placeholder属性")
        
        self.chainedTextView.placeholderColor = placeholderColor
        return self
    }
    
    @discardableResult
    public func keyboardType(_ keyboardType: UIKeyboardType) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    public func layerCornerRadius(_ cornerRadius: CGFloat) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.layer.cornerRadius = cornerRadius
        self.chainedTextView.clipsToBounds = true
        return self
    }
    
    @discardableResult
    public func layerBorderWidthAndBorderColor(_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_TextViewChainedCreater {
        
        self.chainedTextView.layer.borderWidth = borderWidth;
        self.chainedTextView.layer.borderColor = borderColor.cgColor;
        return self
    }

}


extension UITextView {

    private struct AssociatedKeys {
        static var placeholderLabelKey = "placeholderLabelKey"
        static var placeholdColorKey   = "placeholdColorKey"
        static var placeholderKey      = "placeholderKey"
    }
    
    private var placeholderLabel: UILabel  {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderLabelKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderLabelKey) as? UILabel ?? UILabel()
        }
    }
    
    public var placeholderColor: UIColor {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholdColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.placeholderLabel.textColor = placeholderColor
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholdColorKey) as! UIColor
        }
    }
    
    public var placeholder: String {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderKey) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            let size = CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
            let labelSize = (placeholder as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [ NSAttributedStringKey.font: self.placeholderLabel.font], context: nil)
          
            let label = UILabel.cc.zfc_labelChainedCreater { (creater) in
                creater.frame(CGRect(x: 4, y: 5, width: labelSize.width, height: labelSize.height))
                    .font(self.font ?? UIFont.systemFont(ofSize: 15))
                    .textColor(UIColor.lightGray)
                    .textAlignment(.left)
                    .numberOfLines(0)
                    .text(self.placeholder)
                    .addIntoView(self)
            }
            
            self.placeholderLabel = label
            self.placeholderLabel.isHidden = false
    
            NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        }
    }
    
    @objc func textDidChange() {
        
        let isHidden = self.text.map { $0.count > 0 }
        self.placeholderLabel.isHidden = isHidden ?? false
    }

}



extension ChainedCreater where Base: UITextView {
    
    @discardableResult
    public static func zfc_textViewChainedCreater(_ chainedCreaterBlock: (_ creater: ZFC_TextViewChainedCreater) -> ()) -> UITextView {
        
        let chainedCreater = ZFC_TextViewChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedTextView
        
    }
}





