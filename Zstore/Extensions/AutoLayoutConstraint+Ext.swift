//
//  AutoLayoutConstraint+Ext.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 06/11/23.
//

import UIKit


//MARK: UIVIEWCONTROLLER
extension UIViewController {
    @propertyWrapper
    public struct UseAutolayout<T: UIView> {
        public var wrappedValue: T {
            didSet {
                wrappedValue.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        public init(wrappedValue: T) {
            self.wrappedValue = wrappedValue
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

//MARK: UIVIEW
extension UIView {
    func constraintsForAnchoringTo(boundsOf view: UIView) {
        let constraints: [NSLayoutConstraint] = [
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        view.addConstraints(constraints)
    }
    
    func constraintsForAnchoringToWithoutMargin(boundsOf view: UIView) {
        let constraints: [NSLayoutConstraint] = [
            topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        view.addConstraints(constraints)
    }
    
    @propertyWrapper
    public struct UseAutolayout<T: UIView> {
        public var wrappedValue: T {
            didSet {
                wrappedValue.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        public init(wrappedValue: T) {
            self.wrappedValue = wrappedValue
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
