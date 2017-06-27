//
//  CollectionViewCell.swift
//  WeatherApp
//
//  Created by Dung on 6/27/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temporature: UILabel!
   
    override func prepareForReuse() {
        time.text = ""
        imageView.image = nil
        temporature.text = ""
    }
}
