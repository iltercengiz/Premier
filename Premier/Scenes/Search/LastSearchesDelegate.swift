//
//  LastSearchesDelegate.swift
//  Premier
//
//  Created by Ilter Cengiz on 21/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

class LastSearchesDelegate: NSObject {
    
    fileprivate let lastSearchesManager: LastSearchesManager
    
    var selectionHandler: ((String) -> Void)?
    
    init(lastSearchesManager: LastSearchesManager) {
        self.lastSearchesManager = lastSearchesManager
        super.init()
    }
    
}

extension LastSearchesDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = lastSearchesManager.lastSearches[indexPath.row]
        selectionHandler?(query)
    }
    
}
