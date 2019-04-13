//
//  UITextField+cc.swift
//  ChainedDemo-Swift
//
//  Created by 富成赵 on 2019/3/23.
//  Copyright © 2019年 前海创石记（深圳）科技有限公司. All rights reserved.
//

import UIKit

public final class ZFC_TextFieldChainedCreater {
    
    public lazy var chainedTextField: UITextField = {
        
        let textField = UITextField()
        return textField
        
    }()
    
    @discardableResult
    public func addIntoView(_ superView: UIView) -> ZFC_TextFieldChainedCreater {
        superView.addSubview(self.chainedTextField)
        
        return self
    }
    
    @discardableResult
    public func frame(_ frame: CGRect) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.frame = frame
        return self
        
    }
    
    @discardableResult
    public func backgroundColor(_ backgroudColor: UIColor) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.backgroundColor = backgroudColor
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.font = font
        return self
        
    }
    
    @discardableResult
    public func tag(_ tag: Int) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.tag = tag
        return self
        
    }
    
    @discardableResult
    public func text(_ text: String) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.text = text
        return self
    }
    
    @discardableResult
    public func textColor(_ textColor: UIColor) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.textColor = textColor
        return self
    }
    
    @discardableResult
    public func textAlignment(_ textAlignment: NSTextAlignment) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.textAlignment = textAlignment
        return self
    }
    
    
    @discardableResult
    public func borderStyle(_ borderStyle: UITextField.BorderStyle) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.borderStyle = borderStyle
        return self
        
    }
    
    @discardableResult
    public func placeholder(_ placeholder: String) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.placeholder = placeholder
        return self
        
    }
    
    @discardableResult
    public func clearButtonMode(_ clearButtonMode: UITextField.ViewMode) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.clearButtonMode = clearButtonMode
        return self
        
    }
    
    @discardableResult
    public func layerCornerRadius(_ cornerRadius: CGFloat) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.layer.cornerRadius = cornerRadius
        self.chainedTextField.clipsToBounds = true
        return self
    }
    
    @discardableResult
    public func keyboardType(_ keyboardType: UIKeyboardType) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.keyboardType = keyboardType
        return self
        
    }
    
    @discardableResult
    public func layerBorderWidthAndBorderColor(_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_TextFieldChainedCreater {
        
        self.chainedTextField.layer.borderWidth = borderWidth;
        self.chainedTextField.layer.borderColor = borderColor.cgColor;
        return self
        
    }

}


extension ChainedCreater where Base: UITextField {
    
    @discardableResult
    public static func zfc_textFieldChainedCreater(_ chainedCreaterBlock: (_ creater: ZFC_TextFieldChainedCreater) -> ()) -> UITextField {
        
        let chainedCreater = ZFC_TextFieldChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedTextField
        
    }
    
}


