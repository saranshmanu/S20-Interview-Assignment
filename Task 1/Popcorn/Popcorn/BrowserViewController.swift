//
//  BrowserViewController.swift
//  Popcorn
//
//  Created by Saransh Mittal on 21/09/19.
//  Copyright © 2019 Saransh Mittal. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
}

extension BrowserViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        movieCell.movieNameLabel.text = movies[indexPath.row]
        return movieCell
    }
    
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
