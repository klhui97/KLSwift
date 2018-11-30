//
//  Layoutable.swift
//  iOS Practice
//
//  Created by KL on 7/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

public protocol Layoutable {
    var owningView: UIView? { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

public extension Layoutable {
    
    // MARK: - Super view
    public func al_fillSuperview(inset: UIEdgeInsets = .zero) {
        al_fillView(owningView!, inset: inset)
    }
    
    public func al_fillSuperview(margin: CGFloat) {
        al_fillView(owningView!, inset: UIEdgeInsetsMake(margin, margin, margin, margin))
    }
    
    public func al_fillSuperViewHorizontally(alignToSafeArea: Bool = false) {
        let alView = self.owningView!
        if alignToSafeArea {
            NSLayoutConstraint.activate([trailingAnchor.constraint(equalTo: alView.safeLeftAnchor, constant: 0),
                                         leadingAnchor.constraint(equalTo: alView.safeRightAnchor, constant: 0)])
        }else {
            NSLayoutConstraint.activate([trailingAnchor.constraint(equalTo: alView.trailingAnchor, constant: 0),
                                         leadingAnchor.constraint(equalTo: alView.leadingAnchor, constant: 0)])
        }
    }
    
    public func al_fillSuperViewVertically(alignToSafeArea: Bool = false) {
        let alView = self.owningView!
        if alignToSafeArea {
            NSLayoutConstraint.activate([topAnchor.constraint(equalTo: alView.safeTopAnchor, constant: 0),
                                         bottomAnchor.constraint(equalTo: alView.safeBottomAnchor, constant: 0)])
        }else {
            NSLayoutConstraint.activate([topAnchor.constraint(equalTo: alView.topAnchor, constant: 0),
                                         bottomAnchor.constraint(equalTo: alView.bottomAnchor, constant: 0)])
        }
    }
    
    // MARK: - Width and height
    public func al_width(_ width: CGFloat) {
        NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: width)])
    }
    
    public func al_widthEqualToView(_ view: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: constant)])
    }
    
    public func al_height(_ height: CGFloat) {
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: height)])
    }
    
    public func al_heightEqualToView(_ view: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1, constant: constant)])
    }
    
    // MARK: - View
    public func al_fillView(_ view: UIView, inset: UIEdgeInsets = .zero) {
        topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset.bottom).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: inset.right).isActive = true
    }
    
    public func al_fillSafeAreaView(_ view: UIView) {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        } else {
            al_fillView(view)
        }
    }
    
    // MARK: Left or leading
    public func al_leftToSuperview(distance: CGFloat = 0) {
        al_leftToView(owningView!, distance: distance)
    }
    
    public func al_leftToView(_ view: UIView, distance: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distance)
        constraint.isActive = true
        constraint.priority = priority
    }
    
    public func al_leftToMargin(_ view: UIView? = nil) {
        let alView = view ?? owningView!
        NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: alView.layoutMarginsGuide.leadingAnchor)])
    }
    
    // MARK: - Right or trailing
    public func al_rightToMargin(_ view: UIView? = nil) {
        let alView = view ?? owningView!
        NSLayoutConstraint.activate([trailingAnchor.constraint(equalTo: alView.layoutMarginsGuide.trailingAnchor)])
    }
    
    public func al_rightToSuperview(distance: CGFloat = 0) {
        al_rightToView(owningView!, distance: distance)
    }
    
    public func al_rightToView(_ view: UIView, distance: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = rightAnchor.constraint(equalTo: view.rightAnchor, constant: distance)
        constraint.isActive = true
        constraint.priority = priority
    }
    
    // MARK: Top
    public func al_topToSuperview(distance: CGFloat = 0, alignToSafeArea: Bool = false) {
        al_topToView(owningView!, distance: distance, alignToSafeArea: alignToSafeArea)
    }
    
    public func al_topToView(_ view: UIView, distance: CGFloat = 0, alignToSafeArea: Bool = false, priority: UILayoutPriority = .required) {
        if alignToSafeArea {
            let constraint = topAnchor.constraint(equalTo: view.safeTopAnchor, constant: distance)
            constraint.isActive = true
            constraint.priority = priority
        }else {
            let constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: distance)
            constraint.isActive = true
            constraint.priority = priority
        }
    }
    
    // MARK: - Bottom
    public func al_bottomToSuperview(distance: CGFloat = 0, alignToSafeArea: Bool = false) {
        al_bottomToView(owningView!, distance: distance, alignToSafeArea: alignToSafeArea)
    }
    
    public func al_bottomToView(_ view: UIView, distance: CGFloat = 0, alignToSafeArea: Bool = false, priority: UILayoutPriority = .required) {
        if alignToSafeArea {
            let constraint = bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: distance)
            constraint.isActive = true
            constraint.priority = priority
        }else {
            let constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance)
            constraint.isActive = true
            constraint.priority = priority
        }
    }
    
    // MARK: - X and Y
    public func al_centerToView(_ view: UIView? = nil) {
        let alView = view ?? owningView!
        NSLayoutConstraint.activate([centerXAnchor.constraint(equalTo: alView.centerXAnchor, constant: 0),
                                     centerYAnchor.constraint(equalTo: alView.centerYAnchor, constant: 0)])
    }
    
    public func al_centerXToView(_ view: UIView? = nil, constant: CGFloat = 0) {
        let alView = view ?? owningView!
        NSLayoutConstraint.activate([centerXAnchor.constraint(equalTo: alView.centerXAnchor, constant: constant)])
    }
    
    public func al_centerYToView(_ view: UIView? = nil, constant: CGFloat = 0) {
        let alView = view ?? owningView!
        NSLayoutConstraint.activate([centerYAnchor.constraint(equalTo: alView.centerYAnchor, constant: constant)])
    }
}

extension UIView: Layoutable {
    public var owningView: UIView? { return superview }
}
