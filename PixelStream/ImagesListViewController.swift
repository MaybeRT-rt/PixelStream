//
//  ImagesListViewController.swift
//  PixelStream
//
//  Created by Liz-Mary on 21.11.2024.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
    }
    
    func configCell(for cell: ImagesListCell) {
        
    }

}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesListCell", for: indexPath)
        guard let imagesListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imagesListCell)
        return imagesListCell
    }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
