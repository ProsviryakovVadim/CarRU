//
//  String+Extension.swift
//  CarSale
//
//  Created by Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

extension String {
    
    func size(forWidth width: CGFloat, attributes: [String : Any]) -> CGSize {
        return (self as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
    }
    
    enum FontWeight {
        
        case regular
        case medium
        case light
        case thin
        case bold
        case semibold
        case heavy
        
        var value: CGFloat {
            switch self {
            case .regular:
                return UIFontWeightRegular
            case .medium:
                return UIFontWeightMedium
            case .bold:
                return UIFontWeightBold
            case .light:
                return UIFontWeightLight
            case .semibold:
                return UIFontWeightSemibold
            case .heavy:
                return UIFontWeightHeavy
            case .thin:
                return UIFontWeightThin
            }
        }
        
    }
    
    enum Attribute {
        /// Системный шрифт.
        case sysFont(CGFloat, FontWeight)
        case font(UIFont)
        /// Цвет текста.
        case fg(UIColor)
        /// Цвет фона.
        case bg(UIColor)
        /// Выравнивание текста.
        case align(NSTextAlignment)
        /// Отступ после параграфа.
        case ps(CGFloat)
        case psBefore(CGFloat)
        /// Межстрочный интервал.
        case lineSpacing(CGFloat)
        /// Ссылка.
        case link(URL)
        case lineBreakMode(NSLineBreakMode)
        // нижнее подчеркивание
        case underline(Bool)
        
        case firstLineHeadIndent(CGFloat)
        case headIndent(CGFloat)
    }
    
    static func attributes(_ attrs: [Attribute]) -> [String : Any] {
        var kv: [String : Any] = [:]
        let ps = NSMutableParagraphStyle()
        var psChanged = false
        for attr in attrs {
            switch attr {
            case .sysFont(let size, let weight):
                kv[NSFontAttributeName] = UIFont.systemFont(ofSize: size, weight: weight.value)
            case .font(let value):
                kv[NSFontAttributeName] = value
            case .fg(let color):
                kv[NSForegroundColorAttributeName] = color
            case .bg(let color):
                kv[NSBackgroundColorAttributeName] = color
            case .link(let url):
                kv[NSLinkAttributeName] = url
            case .align(let value):
                ps.alignment = value
                psChanged = true
            case .ps(let value):
                ps.paragraphSpacing = value
                psChanged = true
            case .lineSpacing(let value):
                ps.lineSpacing = value
                psChanged = true
            case .psBefore(let value):
                ps.paragraphSpacingBefore = value
                psChanged = true
            case .lineBreakMode(let value):
                ps.lineBreakMode = value
                psChanged = true
            case .firstLineHeadIndent(let value):
                ps.firstLineHeadIndent = value
                psChanged = true
            case .headIndent(let value):
                ps.headIndent = value
                psChanged = true
            case .underline(let value):
                if value {
                    kv[NSUnderlineStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue
                }
            }
        }
        if psChanged {
            kv[NSParagraphStyleAttributeName] = ps
        }
        return kv
    }
    
    static func attributes(_ attrs: Attribute...) -> [String : Any] {
        return attributes(attrs)
    }
    
    func attributed(with attrs: Attribute...) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: String.attributes(attrs))
    }
    
}

extension NSAttributedString {
    
    public func size(forWidth width: CGFloat) -> CGSize {
        return boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size
    }
}

func +=(left: NSMutableAttributedString, right: NSAttributedString) {
    left.append(right)
}

func +=(left: NSMutableAttributedString, right: (String, [String : Any])) {
    left.append(NSAttributedString(string: right.0, attributes: right.1))
}
