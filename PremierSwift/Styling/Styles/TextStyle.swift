//
//  TextStyle.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

protocol TextStyling {
    func ps_styleText(_ textStyle: TextStyle)
}

struct TextStyle {
    
    let font: UIFont
    let color: UIColor
    
    // MARK: - Manipulating color
    
    func with(_ color: UIColor) -> TextStyle {
        return TextStyle(font: font, color: color)
    }
    
    // MARK: - Default text styles
    
    static let body = TextStyle(font: Font.body, color: Color.gray)
    static let title1 = TextStyle(font: Font.title1, color: Color.darkGray)
    
}

// MARK: Extensions

extension UILabel: TextStyling {
    
    func ps_styleText(_ textStyle: TextStyle) {
        font = textStyle.font
        textColor = textStyle.color
    }
}
