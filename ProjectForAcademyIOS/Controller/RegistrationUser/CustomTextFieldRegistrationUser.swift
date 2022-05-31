//
//  CustomTextFieldRegistrationUser.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 27.05.2022.
//

import Foundation
import UIKit

class CustomTextFieldRegUser: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    init(placeHolder: String?=nil) {
        super.init(frame: CGRect.zero)
        
        font = UIFont.systemFont(ofSize: 14)
        returnKeyType = .next
        
        attributedPlaceholder = NSAttributedString(string: placeHolder ?? "")
        
        autocorrectionType = .no
        autocapitalizationType = .none
        enablesReturnKeyAutomatically = true
        
        tintColor = .black
        textColor = .black
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 45)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
