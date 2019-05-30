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
    
    fileprivate lazy var chainedImageView: UIImageView = {
        
        let imageView = UIImageView()
        return imageView
    }()
    
    @discardableResult
    public func imageViewClass(_ imageViewClass: UIImageView.Type) -> ZFC_ImageViewChainedCreater {
        
        chainedImageView = imageViewClass.init()
        return self
    }
    
    @discardableResult
    public func addIntoView(_ superView: UIView) -> ZFC_ImageViewChainedCreater {
        superView.addSubview(self.chainedImageView)
        
        return self
    }
    
    @discardableResult
    public func frame(_ frame: CGRect) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.frame = frame
        
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ backgroudColor: UIColor) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.backgroundColor = backgroudColor
        
        return self
    }
    
    @discardableResult
    public func tag(_ tag: Int) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.tag = tag
        
        return self
    }
    
    @discardableResult
    public func layerCornerRadius(_ cornerRadius: CGFloat) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.layer.cornerRadius = cornerRadius
        self.chainedImageView.clipsToBounds = true
        
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.image = image
        
        return self
    }
    
    @discardableResult
    public func contentMode(_ contentMode: UIView.ContentMode) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.contentMode = contentMode
        
        return self
    }
    
    @discardableResult
    public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.isUserInteractionEnabled = isUserInteractionEnabled
        
        return self
    }
    
    @discardableResult
    public func layerBorderWidthAndBorderColor(_ borderWidth: CGFloat, _ borderColor: UIColor) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.layer.borderWidth = borderWidth;
        self.chainedImageView.layer.borderColor = borderColor.cgColor;
        
        return self
    }
    
    @discardableResult
    public func tapBlock(_ tapBlock: @escaping(ZFC_CreaterImageViewTapBlock)) -> ZFC_ImageViewChainedCreater {
        
        self.chainedImageView.isUserInteractionEnabled = true
        self.keepBlock = tapBlock
        
        return self
    }
    
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
    public static func zfc_imageViewChainedCreater(_ chainedCreaterBlock: (_ creater: ZFC_ImageViewChainedCreater) -> ()) -> UIImageView {
        
        let chainedCreater = ZFC_ImageViewChainedCreater()
        chainedCreaterBlock(chainedCreater)
        return chainedCreater.chainedImageView
        
    }
    
}
