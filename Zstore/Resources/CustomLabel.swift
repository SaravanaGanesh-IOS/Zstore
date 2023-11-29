//
//  CustomLabel.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 09/11/23.
//

import UIKit
enum LabelType: Int, CaseIterable {
    case heading = 0, title, subHeadline, callout, footnote
}

class CustomLabel: UILabel {
    lazy var lineCount: Int = 0 {
        didSet {
            configLabel()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLabel()
        
    }
    
    convenience init(with type: UIFont.TextStyle, color: UIColor? = nil) {
        self.init(frame: .zero)
        self.font = UIFont.preferredFont(forTextStyle: type, compatibleWith: .current)
        self.textColor = color == nil ? .black : color
    }
    
    convenience init(with fontSize: CGFloat? = nil, textWeight weight: UIFont.Weight? = nil, textColor color: UIColor? = nil) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize ?? 11, weight: weight ?? .regular)
        self.textColor = color == nil ? .black : color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configLabel()
    }
    
    private func configLabel() {
        self.numberOfLines = lineCount
        self.lineBreakMode = lineCount == 0 ? .byWordWrapping : .byTruncatingTail
        self.sizeToFit()
    }
}

extension CustomLabel {
    func strikeThrough(_ isStrikeThrough: Bool = true) {
        guard let text = self.text else {
            return
        }
        
        if isStrikeThrough {
            let attributeString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
            self.attributedText = attributeString
        } else {
            let attributeString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: [], range: NSMakeRange(0,attributeString.length))
            self.attributedText = attributeString
        }
    }
}
