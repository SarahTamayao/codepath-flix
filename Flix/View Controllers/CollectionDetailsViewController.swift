//
//  CollectionDetailsViewController.swift
//  Flix
//
//  Created by Harshad Barapatre on 2/10/22.
//

import UIKit

class CollectionDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var genre: [String: Any]!
    var movies = [[String: Any]]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = genre["name"] as? String
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        
        let genreID: Int = genre["id"] as! Int
        let genreIDString = String(genreID)
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&with_genres=" + genreIDString
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(dataDictionary)
                    self.movies = dataDictionary["results"] as! [[String: Any]]
                 print(self.movies)
//
                    self.collectionView.reloadData()
             }
        }
        task.resume()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
    
        let movie = movies[indexPath.row]
//        let movieName = movie["title"] as! String
        
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)
        cell.moviePoster.af.setImage(withURL: posterUrl!)

        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
        
        let detailViewController = segue.destination as! MovieDetailsViewController
        detailViewController.movie = movie
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
