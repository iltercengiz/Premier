//
//  LastSearchesDataSource.swift
//  Premier
//
//  Created by Ilter Cengiz on 21/05/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

class LastSearchesDataSource: NSObject {
    
    fileprivate let lastSearchesManager: LastSearchesManager
    
    init(lastSearchesManager: LastSearchesManager) {
        self.lastSearchesManager = lastSearchesManager
        super.init()
    }
    
}

extension LastSearchesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LastSearchesTableViewCell.defaultReuseIdentifier,
                                                 for: indexPath) as! LastSearchesTableViewCell
        let query = lastSearchesManager.lastSearches[indexPath.row]
        cell.configure(with: query)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastSearchesManager.lastSearches.count
    }
    
}
