//
//  File.swift
//  ChainedDemo-Swift
//
//  Created by 富成赵 on 2019/3/23.
//  Copyright © 2019年 前海创石记（深圳）科技有限公司. All rights reserved.
//


public final class ChainedCreater<Base> {
    
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
    
}


public protocol ChainedCreaterCompatible {
    
    associatedtype T

    static var cc: T.Type { get }
    
    var cc: T { get }
    
}


public extension ChainedCreaterCompatible {
    
    public static var cc: ChainedCreater<Self>.Type {
        return ChainedCreater<Self>.self
    }
    
    var cc: ChainedCreater<Self> {
        return ChainedCreater(self)
    }
    
}


import class UIKit.UIView
extension UIView: ChainedCreaterCompatible {}






