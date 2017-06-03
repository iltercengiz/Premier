//
//  LastSearchesTableViewCell.swift
//  Premier
//
//  Created by Ilter Cengiz on 21/05/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

class LastSearchesTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func configure(with query: String) {
        textLabel?.text = query
    }
    
}

private extension LastSearchesTableViewCell {
    
    func setup() {
        textLabel?.ps_styleText(TextStyle.body)
        textLabel?.textAlignment = .center
    }
    
}
