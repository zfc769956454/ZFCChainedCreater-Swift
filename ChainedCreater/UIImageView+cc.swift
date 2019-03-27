//
//  UIImageView+cc.swift
//  ChainedDemo-Swift
//
//  Created by 富成赵 on 2019/3/23.
//  Copyright © 2019年 前海创石记（深圳）科技有限公司. All rights reserved.
//

import UIKit

public typealias ZFC_CreaterImageViewTapBlock = (_ imageView: UIImageView) -> ()

public final class ZFC_ImageViewChainedCreater {
    
    private var keepBlock: ZFC_CreaterImageViewTapBlock?
    
    public lazy var chainedImageView: UIImageView = {
        
        let imageView = UIImageView()
        return imageView
        
    }()
    
    public var addIntoView: (_ superView: UIView) -> ZFC_ImageViewChainedCreater {
        return { superView in
    
            superView.addSubview(self.chainedImageView)
            
            return self
            
        }
    }
    
    public var frame: (_ frame: CGRect) -> ZFC_ImageViewChainedCreater {
        
        return { frame in
            
            self.chainedImageView.frame = frame
            
            return self
            
        }
    }
    
    public var backgroundColor: (_ backgroudColor: UIColor) -> ZFC_ImageViewChainedCreater {
        
        return { backgroudColor in
            
            self.chainedImageView.backgroundColor = backgroudColor
            
            return self
            
        }
    }
    
    public var tag: (_ tag: Int) -> ZFC_ImageViewChainedCreater {
        
        return { tag in
            
            self.chainedImageView.tag = tag
            
            return self
        }
    }
    
    public var layerCornerRadius: (_ cornerRadius: CGFloat) -> ZFC_ImageViewChainedCreater {
        
        return { cornerRadius in
            
            self.chainedImageView.layer.cornerRadius = cornerRadius
            self.chainedImageView.clipsToBounds = true
            
            return self
        }
    }
    
    public var image: (_ image: UIImage) -> ZFC_ImageViewChainedCreater {
        
        return { image in
            
            self.chainedImageView.image = image
            
            return self
            
        }
    }
    
    public var contentMode: (_ contentMode: UIView.ContentMode) -> ZFC_ImageViewChainedCreater {
        
        return { contentMode in
            
            self.chainedImageView.contentMode = contentMode
            
            return self
        }
    }
    
    public var isUserInteractionEnabled: (_ isUserInteractionEnabled: Bool) -> ZFC_ImageViewChainedCreater {
        
        return { isUserInteractionEnabled in
            
            self.chainedImageView.isUserInteractionEnabled = isUserInteractionEnabled
            
            return self
        }
    }
    
    public var layerBorderWidthAndBorderColor: (_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_ImageViewChainedCreater {
        
        return { (borderWidth,borderColor) in
            
            self.chainedImageView.layer.borderWidth = borderWidth;
            self.chainedImageView.layer.borderColor = borderColor.cgColor;
            
            return self
        }
    }
    
    public var tapBlock: (_ tapBlock: @escaping(ZFC_CreaterImageViewTapBlock)) -> ZFC_ImageViewChainedCreater {
        
        return { tapBlock in
            
            self.chainedImageView.isUserInteractionEnabled = true
            self.keepBlock = tapBlock
            
            return self
        }
    }
    
    public func end() {}
    
    init() {
        
        self.chainedImageView.create_tapBlock(byValueBlock: { (imageView) in
            
            guard let keepBlock = self.keepBlock else {return}
            keepBlock(imageView)
            
        }, imageView: self.chainedImageView)
        
    }
    
}


extension UIImageView {
    
    private struct AssociatedKeys {
        static var imageViewTapKey = "imageViewTapKey"
    }
    
    fileprivate func create_tapBlock(byValueBlock: ZFC_CreaterImageViewTapBlock?, imageView: UIImageView) {
        
        objc_setAssociatedObject(self, &AssociatedKeys.imageViewTapKey, byValueBlock, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageTap))
        imageView.addGestureRecognizer(tap)
        
    }
    
    
    @objc func imageTap(tap: UITapGestureRecognizer) {
        
        guard let byValueBlock = (objc_getAssociatedObject(self, &AssociatedKeys.imageViewTapKey) as? ZFC_CreaterImageViewTapBlock) else {return};
        
        byValueBlock(tap.view as! UIImageView)
        
    }
}


extension ChainedCreater where Base: UIImageView {
    
    @discardableResult
    public static func zfc_imageViewChainedCreater(chainedCreaterBlock: @escaping(_ creater: ZFC_ImageViewChainedCreater) -> ()) -> UIImageView {
        
        let chainedCreater = ZFC_ImageViewChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedImageView
        
    }
    
}
