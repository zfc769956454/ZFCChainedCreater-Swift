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
    
    
    public var addIntoView: (_ superView: UIView) -> ZFC_TextViewChainedCreater {
        return { superView in
            
            superView.addSubview(self.chainedTextView)
            return self
            
        }
    }
    
    
    public var frame: (_ frame: CGRect) -> ZFC_TextViewChainedCreater {
        
        return { frame in
            
            self.chainedTextView.frame = frame
            return self
            
        }
    }
    
    public var backgroundColor: (_ backgroudColor: UIColor) -> ZFC_TextViewChainedCreater {
        
        return { backgroudColor in
            
            self.chainedTextView.backgroundColor = backgroudColor
            return self
            
        }
    }
    
    
    public var font: (_ font: UIFont) -> ZFC_TextViewChainedCreater {
        
        return { font in
            
            self.chainedTextView.font = font
            return self
        }
    }
    
    
    public var tag: (_ tag: Int) -> ZFC_TextViewChainedCreater {
        
        return { tag in
            
            self.chainedTextView.tag = tag
            return self
        }
    }
    
    public var text: (_ text: String) -> ZFC_TextViewChainedCreater {
        
        return { text in
            
            self.chainedTextView.text = text
            return self
        }
    }
    
  
    public var placeholder: (_ placeholder: String) -> ZFC_TextViewChainedCreater {

        return { placeholder in

            self.chainedTextView.placeholder = placeholder
            return self
        }
    }
    
    public var placeholderColor: (_ placeholderColor: UIColor) -> ZFC_TextViewChainedCreater {
        
        return { placeholderColor in
            
            assert(self.chainedTextView.placeholder.count > 0, "请先设置placeholder属性")
            
            self.chainedTextView.placeholderColor = placeholderColor
            return self
        }
    }
    
    public var keyboardType: (_ keyboardType: UIKeyboardType) -> ZFC_TextViewChainedCreater {
        
        return { keyboardType in
            
            self.chainedTextView.keyboardType = keyboardType
            return self
        }
    }
    
    public var layerCornerRadius: (_ cornerRadius: CGFloat) -> ZFC_TextViewChainedCreater {
        
        return { cornerRadius in
            
            self.chainedTextView.layer.cornerRadius = cornerRadius
            self.chainedTextView.clipsToBounds = true
            return self
        }
    }
    

    public var layerBorderWidthAndBorderColor: (_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_TextViewChainedCreater {
        
        return { (borderWidth,borderColor) in
            
            self.chainedTextView.layer.borderWidth = borderWidth;
            self.chainedTextView.layer.borderColor = borderColor.cgColor;
            return self
        }
    }
    
    public func end() {}
    
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
          
            let label = UILabel.cc.zfc_labelChainedCreater(chainedCreaterBlock: { (creater) in
                creater.frame(CGRect(x: 4, y: 5, width: labelSize.width, height: labelSize.height))
                    .font(self.font ?? UIFont.systemFont(ofSize: 15))
                    .textColor(UIColor.lightGray)
                    .textAlignment(.left)
                    .numberOfLines(0)
                    .text(self.placeholder)
                    .addIntoView(self)
                    .end()
            })
            
            self.placeholderLabel = label
            self.placeholderLabel.isHidden = false
    
            NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        }
    }
    
    @objc func textDidChange() {
        
        let isHidden = self.text.map { $0.count > 0 } ?? false
        self.placeholderLabel.isHidden = isHidden
    }

}



extension ChainedCreater where Base: UITextView {
    
    @discardableResult
    public static func zfc_textViewChainedCreater(chainedCreaterBlock: @escaping(_ creater: ZFC_TextViewChainedCreater) -> ()) -> UITextView {
        
        let chainedCreater = ZFC_TextViewChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedTextView
        
    }
}





