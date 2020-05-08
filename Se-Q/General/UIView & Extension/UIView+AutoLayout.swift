//
//  UIView+AutoLayout.swift
//  Se-Q
//
//  Created by rahman fad on 07/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//


import UIKit

extension UILayoutPriority {
    static var Low: Float { return 250.0 }
    static var High: Float { return 750.0 }
    static var Required: Float { return 1000.0 }
}

extension UIView {
    enum Side{
        case top
        case right
        case bottom
        case left
    }
    
    private enum Dimension {
        case width
        case maxWidth
        case minWidth
        
        case height
        case maxHeight
        case minHeight
    }
}

// MARK: - Centering
extension UIView {
    @discardableResult
    func centerInSuperview() -> [NSLayoutConstraint]{
        return  [centerHorizontallyInSuperview(), centerVerticallyInSuperview()]
    }
    
    @discardableResult
    func centerHorizontallyInSuperview() -> NSLayoutConstraint {
        return pinEqualAttribute(NSLayoutConstraint.Attribute.centerX, withView: self.superview!)
    }
    
    @discardableResult
    func centerVerticallyInSuperview() -> NSLayoutConstraint {
        return pinEqualAttribute(NSLayoutConstraint.Attribute.centerY, withView: self.superview!)
    }
}

// MARK: - Pin
extension UIView {
    @discardableResult
    func pinWidth(_ width: CGFloat) -> NSLayoutConstraint {
        return pinDimension(.width, value: width)
    }
    
    @discardableResult
    func pinHeight(_ height: CGFloat) -> NSLayoutConstraint {
        return pinDimension(.height, value: height)
    }
    
    @discardableResult
    func pinMinWidth(_ minWidth: CGFloat) -> NSLayoutConstraint {
        return pinDimension(.minWidth, value: minWidth)
    }
    
    @discardableResult
    func pinMinHeight(_ minHeight: CGFloat) -> NSLayoutConstraint {
        return pinDimension(.minHeight, value: minHeight)
    }
    
    @discardableResult
    func pinMaxWidth(_ maxWidth: CGFloat) -> NSLayoutConstraint {
        return pinDimension(.maxWidth, value: maxWidth)
    }
    
    @discardableResult
    func pinMaxHeight(_ maxHeight: CGFloat) -> NSLayoutConstraint {
        return pinDimension(.maxHeight, value: maxHeight)
    }
    
    @discardableResult
    func pinWidthView(_ toWidthOfView: UIView) -> NSLayoutConstraint {
        return pinEqualAttribute(NSLayoutConstraint.Attribute.width, withView: toWidthOfView)
    }
    
    @discardableResult
    func pinHeightView(_ toHeightOfView: UIView) -> NSLayoutConstraint {
        return pinEqualAttribute(NSLayoutConstraint.Attribute.height, withView: toHeightOfView)
    }
    
    @discardableResult
    func pinLeft(_ view: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        return align(.left, withSide: .left, of: view, distance: distance)
    }
    
    @discardableResult
    func pinTop(_ view: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        return align(.top, withSide: .top, of: view, distance: distance)
    }
    
    @discardableResult
    func pinRight(_ view: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        return align(.right, withSide: .right, of: view, distance: distance)
    }
    
    @discardableResult
    func pinBottom(_ view: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        return align(.bottom, withSide: .bottom, of: view, distance: distance)
    }
    
    @discardableResult
    func pinLeftAndRight(_ view: UIView) -> [NSLayoutConstraint] {
        return [pinLeft(view), pinRight(view)]
    }
    
    @discardableResult
    func pinTopAndBottom(_ view: UIView) -> [NSLayoutConstraint] {
        return [pinTop(view), pinBottom(view)]
    }
    
    @discardableResult
    func pinCenterHorizontal(_ view: UIView) -> NSLayoutConstraint {
        return pinEqualAttribute(NSLayoutConstraint.Attribute.centerX, withView: view)
    }
    
    @discardableResult
    func pinCenterVertical(_ view: UIView) -> NSLayoutConstraint {
        return pinEqualAttribute(NSLayoutConstraint.Attribute.centerY, withView: view)
    }
}

// MARK: - Fill
extension UIView {
    @discardableResult
    @objc
    func fillSuperView() -> [NSLayoutConstraint] {
        return fillSuperViewWidth() + fillSuperViewHeight()
    }
    
    @discardableResult
    @objc
    func fillSuperViewWidth() -> [NSLayoutConstraint] {
        return [alignWithSuperview(Side.left), alignWithSuperview(Side.right)]
    }
    
    @discardableResult
    @objc
    func fillSuperViewHeight() -> [NSLayoutConstraint] {
        return [alignWithSuperview(Side.top), alignWithSuperview(Side.bottom)]
    }
}

// MARK: - Align
extension UIView {
    @discardableResult
    func alignWithSuperview(_ side: Side, distance: CGFloat = 0) -> NSLayoutConstraint {
        return align(side, withSuperviewSide: side, distance: distance)
    }
    
    @discardableResult
    func alignWithSuperview(sides: [Side], distance: CGFloat = 0) -> [NSLayoutConstraint] {
        var layoutConstraint: [NSLayoutConstraint] = []
        for side in sides {
            layoutConstraint.append(align(side, withSuperviewSide: side, distance: distance))
        }
        return layoutConstraint
    }
    
    @discardableResult
    func alignWithSuperviewSides(_ distance: CGFloat = 0) -> [NSLayoutConstraint] {
        return alignWithSuperview(sides: [.top, .right, .bottom, .left], distance: distance)
    }
    
    @discardableResult
    func align(_ side: Side, withSuperviewSide superviewSide: Side, distance: CGFloat = 0) -> NSLayoutConstraint {
        return align(side, withSide: superviewSide, of: self.superview!, distance: distance)
    }
    
    @discardableResult
    func align(_ side: Side, withSide otherSide: Side, of view: UIView, distance: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let convertedDistance = side == otherSide && (side == .right || side == .bottom)
            ? -distance
            : distance
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: layoutAttribute(for: side),
                                            relatedBy: relation,
                                            toItem: view,
                                            attribute: layoutAttribute(for: otherSide),
                                            multiplier: 1.0,
                                            constant: convertedDistance)
        
        constraint.isActive = true
        
        return constraint
    }
}

// MARK: - Helper
extension UIView {
    @discardableResult
    private func  layoutAttribute(for side: Side) -> NSLayoutConstraint.Attribute {
        switch side {
        case .left:
            return NSLayoutConstraint.Attribute.left
        case .top:
            return NSLayoutConstraint.Attribute.top
        case .right:
            return NSLayoutConstraint.Attribute.right
        case .bottom:
            return NSLayoutConstraint.Attribute.bottom
        }
    }
    
    @discardableResult
    private func layoutAttribute(for dimension: Dimension) -> NSLayoutConstraint.Attribute {
        switch dimension {
        case .width, .minWidth, .maxWidth:
            return NSLayoutConstraint.Attribute.width
        case .height, .minHeight, .maxHeight:
            return NSLayoutConstraint.Attribute.height
        }
    }
    
    @discardableResult
    private func relation(for dimension: Dimension) -> NSLayoutConstraint.Relation {
        switch dimension {
        case .width,.height:
            return NSLayoutConstraint.Relation.equal
        case .minWidth, .minHeight:
            return NSLayoutConstraint.Relation.greaterThanOrEqual
        case .maxWidth, .maxHeight:
            return NSLayoutConstraint.Relation.lessThanOrEqual
        }
    }
    
    @discardableResult
    private func pinDimension(_ dimension: Dimension, value: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: layoutAttribute(for: dimension),
                                            relatedBy: relation(for: dimension),
                                            toItem: nil,
                                            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                            multiplier: 1.0,
                                            constant: value)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    private func pinEqualAttribute(_ attribute: NSLayoutConstraint.Attribute,
                                     withView view: UIView,
                                              constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = NSLayoutConstraint(item: self,
                                             attribute: attribute,
                                             relatedBy: NSLayoutConstraint.Relation.equal,
                                             toItem: view,
                                             attribute: attribute,
                                             multiplier: 1.0,
                                             constant: constant)
        
        constraints.isActive = true
        
        return constraints
    }
    
    func addSubviewVertical(_ subviews: [UIView]) {
        var previousView: UIView? = nil
        for subview in subviews {
            self.addSubview(subview)
            subview.fillSuperViewWidth()
            
            if let previousView = previousView {
                subview.align(.top, withSide: .bottom, of: previousView)
            }
            else {
                subview.alignWithSuperview(.top)
            }
            
            previousView = subview
        }
        
        previousView?.alignWithSuperview(.bottom)
    }
}

protocol LayoutElementConvertible {}

extension UIView: LayoutElementConvertible {}
extension CGFloat: LayoutElementConvertible {}
extension Double: LayoutElementConvertible {}
extension Int: LayoutElementConvertible {}

struct LayoutElement: LayoutElementConvertible {
    let view: UIView
    let dimension: CGFloat
}

// Visual Format Language
extension UIView {
    enum Distribution: String{
        case horizontal = "H"
        case vertical = "V"
    }
    
    @discardableResult
    static func createLayout(_ layoutElement: [LayoutElementConvertible], distribution: Distribution, options: NSLayoutConstraint.FormatOptions = []) -> [NSLayoutConstraint]{
        var viewDictionary: [String: UIView] = [String : UIView]()
        var matricsDictionary: [String: NSNumber] = [String : NSNumber]()
        
        var visualFormat = "\(distribution.rawValue):"
        
        for (index, element) in layoutElement.enumerated() {
            if (index == 0 && element is NSNumber){
                visualFormat += "|-"
            }
            
            let key = "e\(index)"
            
            if let view = element as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
                viewDictionary[key] = view
                visualFormat += "[\(key)]"
            } else if let layoutElement = element as? LayoutElement {
                let view = layoutElement.view
                view.translatesAutoresizingMaskIntoConstraints = false
                viewDictionary[key] = view
                visualFormat += "[\(key)(\(layoutElement.dimension))]"
            } else {
                let matric = element as! NSNumber
                matricsDictionary[key] = matric
                visualFormat += key
            }
            
            if index != layoutElement.count - 1{
                visualFormat += "-"
            } else {
                if element is NSNumber {
                    visualFormat += "-|"
                }
            }
        }
        
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                                                                          options: options,
                                                                          metrics: matricsDictionary,
                                                                          views: viewDictionary)
        NSLayoutConstraint.activate(constraints)
        
        return constraints
    }
}

