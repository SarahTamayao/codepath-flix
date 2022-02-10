//
//  CollectionsViewController.swift
//  Flix
//
//  Created by Harshad Barapatre on 2/9/22.
//

import UIKit
import SwiftUI

class CollectionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var flixMovies = [[String: Any]]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        
        layout.itemSize = CGSize(width: width, height: width * 1.55)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/640146/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    self.flixMovies = dataDictionary["results"] as! [[String: Any]]
                 
                    self.collectionView.reloadData()
             }
        }
        task.resume()
        
        let url2 = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request2 = URLRequest(url: url2, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session2 = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task2 = session2.dataTask(with: request2) { (data, response, error) in
             if let error = error {
                 print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary2 = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 let genres = dataDictionary2["genres"] as! NSArray
                 print(genres)
             }
        }
        task2.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flixMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let movie = flixMovies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w342/"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.collectionPoster.af.setImage(withURL: posterUrl!)
        
        return cell
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
