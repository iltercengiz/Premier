//
//  Font.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

struct Font {
    
    static let body = font(textStyle: .body)
    static let title1 = font(textStyle: .title1)
    
}

// MARK: - Font creators

private extension Font {
    
    static func font(textStyle: UIFontTextStyle) -> UIFont {
        return UIFont.preferredFont(forTextStyle: textStyle)
    }
    
}
