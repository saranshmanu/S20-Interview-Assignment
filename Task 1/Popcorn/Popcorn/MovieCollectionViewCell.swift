//
//  MovieCollectionViewCell.swift
//  Popcorn
//
//  Created by Saransh Mittal on 21/09/19.
//  Copyright © 2019 Saransh Mittal. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    func initCardView() {
        cardView.layer.cornerRadius = 10
    }
    
    override func awakeFromNib() {
        initCardView()
    }
}
