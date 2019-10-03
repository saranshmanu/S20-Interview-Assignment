//
//  RatingsViewController.swift
//  Popcorn
//
//  Created by Saransh Mittal on 21/09/19.
//  Copyright © 2019 Saransh Mittal. All rights reserved.
//

import UIKit
import CoreML

class RatingsViewController: UIViewController {
    
    let vectorSize = 5379
    var model: popcorn? = nil
    
    func getRanking(input: [Double]) -> NSDictionary? {
        let moviesMLArray = try? MLMultiArray(shape: [NSNumber(value: input.count)], dataType: MLMultiArrayDataType.double)
        for i in 0..<input.count {
            moviesMLArray?[i] = NSNumber(value: input[i])
        }
        if let output = try? model?.prediction(input1: moviesMLArray!) {
            return output.output1 as NSDictionary
        }
        return nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBOutlet weak var ratingSliderOne: UISlider!
    @IBOutlet weak var ratingsSliderTwo: UISlider!
    @IBOutlet weak var ratingsSliderThree: UISlider!
    @IBOutlet weak var ratingsSliderFour: UISlider!
    @IBOutlet weak var ratingsSliderFive: UISlider!
    @IBOutlet weak var ratingsSliderSix: UISlider!
    @IBOutlet weak var ratingsSliderSeven: UISlider!
    
    let movieIDs = [924, 905, 916, 26, 20, 16, 69]
    
    @IBAction func browseRating(_ sender: Any) {
        movies.removeAll()
        print(ratingSliderOne.value)
        model = popcorn()
        var movieRatingVector = [Double]()
        //1.1298828125
        for _ in 0...vectorSize-1 {
            movieRatingVector.append(0)
        }
        for i in 0...movieIDs.count-1 {
            let movieID = movieIDs[i]
            let index = moviesListed.firstIndex(of: String(movieID))
            if i == 0 {
                movieRatingVector[index!] = Double(ratingSliderOne.value)
            } else if i == 1 {
                movieRatingVector[index!] = Double(ratingsSliderTwo.value)
            } else if i == 2 {
                movieRatingVector[index!] = Double(ratingsSliderThree.value)
            } else if i == 3 {
                movieRatingVector[index!] = Double(ratingsSliderFour.value)
            } else if i == 4 {
                movieRatingVector[index!] = Double(ratingsSliderFive.value)
            } else if i == 5 {
                movieRatingVector[index!] = Double(ratingsSliderSix.value)
            } else {
                movieRatingVector[index!] = Double(ratingsSliderSeven.value)
            }
        }
        let ranking = getRanking(input: movieRatingVector) as! [String: Double]
        let sortedRanking = ranking.sorted(by: { (one, two) -> Bool in
            one.value > two.value
        })
        if let path = Bundle.main.path(forResource: "Movies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let JSONResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let JSONResult = JSONResult as? Dictionary<String, String> {
                    for (i, _) in sortedRanking {
                        let movieName: String = JSONResult[i]!
                        movies.append(movieName)
                    }
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
        }
        self.performSegue(withIdentifier: "browser", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
