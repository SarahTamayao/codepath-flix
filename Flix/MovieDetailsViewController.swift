//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Harshad Barapatre on 2/9/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieBackdrop: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayImageDetails()
        // Do any additional setup after loading the view.
    }
    
    func displayImageDetails() {
        movieTitle.text = movie["title"] as? String
        movieTitle.sizeToFit()
        movieSynopsis.text = movie["overview"] as? String
        movieSynopsis.sizeToFit()
        
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)
        moviePoster.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/original/" + backdropPath)
        movieBackdrop.af.setImage(withURL: backdropUrl!)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
