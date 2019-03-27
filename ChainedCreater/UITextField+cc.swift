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
    
    
    public var addIntoView: (_ superView: UIView) -> ZFC_TextFieldChainedCreater {
        return { superView in
            
            superView.addSubview(self.chainedTextField)
            return self
            
        }
    }
    
    
    public var frame: (_ frame: CGRect) -> ZFC_TextFieldChainedCreater {
        
        return { frame in
            
            self.chainedTextField.frame = frame
            return self
            
        }
    }
    
    public var backgroundColor: (_ backgroudColor: UIColor) -> ZFC_TextFieldChainedCreater {
        
        return { backgroudColor in
            
            self.chainedTextField.backgroundColor = backgroudColor
            return self
            
        }
    }
    
    
    public var font: (_ font: UIFont) -> ZFC_TextFieldChainedCreater {
        
        return { font in
            
            self.chainedTextField.font = font
            return self
        }
    }
    
    
    public var tag: (_ tag: Int) -> ZFC_TextFieldChainedCreater {
        
        return { tag in
            
            self.chainedTextField.tag = tag
            return self
        }
    }
    
    public var text: (_ text: String) -> ZFC_TextFieldChainedCreater {
        
        return { text in
            
            self.chainedTextField.text = text
            return self
        }
    }
    
    public var borderStyle: (_ borderStyle: UITextField.BorderStyle) -> ZFC_TextFieldChainedCreater {
        
        return { borderStyle in
            
            self.chainedTextField.borderStyle = borderStyle
            return self
        }
    }
    
    public var placeholder: (_ placeholder: String) -> ZFC_TextFieldChainedCreater {
        
        return { placeholder in
            
            self.chainedTextField.placeholder = placeholder
            return self
        }
    }
    
    public var clearButtonMode: (_ clearButtonMode: UITextField.ViewMode) -> ZFC_TextFieldChainedCreater {
        
        return { clearButtonMode in
            
            self.chainedTextField.clearButtonMode = clearButtonMode
            return self
        }
    }
    
    
    public var layerCornerRadius: (_ cornerRadius: CGFloat) -> ZFC_TextFieldChainedCreater {
        
        return { cornerRadius in
            
            self.chainedTextField.layer.cornerRadius = cornerRadius
            self.chainedTextField.clipsToBounds = true
            return self
        }
    }
    
    
    public var keyboardType: (_ keyboardType: UIKeyboardType) -> ZFC_TextFieldChainedCreater {
        
        return { keyboardType in
            
            self.chainedTextField.keyboardType = keyboardType
            return self
        }
    }
    
    
    public var layerBorderWidthAndBorderColor: (_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_TextFieldChainedCreater {
        
        return { (borderWidth,borderColor) in
            
            self.chainedTextField.layer.borderWidth = borderWidth;
            self.chainedTextField.layer.borderColor = borderColor.cgColor;
            return self
        }
    }
    
    public func end() {}
    
}


extension ChainedCreater where Base: UITextField {
    
    @discardableResult
    public static func zfc_textFieldChainedCreater(chainedCreaterBlock: @escaping(_ creater: ZFC_TextFieldChainedCreater) -> ()) -> UITextField {
        
        let chainedCreater = ZFC_TextFieldChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedTextField
        
    }
    
}


