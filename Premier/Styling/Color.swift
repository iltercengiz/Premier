//
//  Color.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

struct Color {
    
    static let gray = UIColor.gray
    static let darkGray = UIColor.darkGray
    
}

// MARK: - Color creators

private extension Color {
    
    func color(white: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return color(red: white,
                     green: white,
                     blue: white,
                     alpha: alpha)
    }
    
    func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        let divider: CGFloat = 255.0
        return UIColor(red: red/divider,
                       green: green/divider,
                       blue: blue/divider,
                       alpha: alpha)
    }
    
}
