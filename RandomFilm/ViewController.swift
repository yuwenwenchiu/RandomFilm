//
//  ViewController.swift
//  RandomFilm
//
//  Created by Yuwen Chiu on 2019/8/28.
//  Copyright © 2019 YuwenChiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    var infoTableViewController: InfoTableViewController?
    var index = 0
    let apiAddress = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getFilm(address: apiAddress)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "moreInfo"{
            infoTableViewController = segue.destination as? InfoTableViewController
        }
    }
    
    @IBAction func newFilm(_ sender: UIBarButtonItem) {
        
        index = Int.random(in: 0...9)
        getFilm(address: apiAddress)
    }
    
    func getFilm(address: String) {
        
        loadActivityIndicator.startAnimating()
        
        if let url = URL(string: address) {
            
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.popAlert()
                    }
                    print(error!.localizedDescription)
                    return
                }
                
                if let getData = data {
                    
                    do {
                        let okData = try JSONDecoder().decode(AllData.self, from: getData)
                        let okArtistName = okData.feed?.results?[self.index].artistName
                        let okReleaseDate = okData.feed?.results?[self.index].releaseDate
                        let okName = okData.feed?.results?[self.index].name
                        let okArtworkUrl100 = okData.feed?.results?[self.index].artworkUrl100
                        let okGenres = okData.feed?.results?[self.index].genres?[0].name
                        let aFilm = Film(filmName: okName, filmImage: okArtworkUrl100, director: okArtistName, genre: okGenres, releaseDate: okReleaseDate)
                        DispatchQueue.main.async {
                            self.settingInfo(film: aFilm)
                        }
                        
                    } catch {
                        DispatchQueue.main.async {
                            self.popAlert()
                        }
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
    
    func settingInfo(film: Film) {
        
        if let imageAddress = film.filmImage {
            
            if let imageURL = URL(string: imageAddress) {
                
                let task = URLSession.shared.downloadTask(with: imageURL) {
                    (data, response, error) in
                    
                    if error != nil {
                        DispatchQueue.main.async {
                            self.popAlert()
                        }
                        print(error!.localizedDescription)
                        return
                    }
                    
                    if let getURL = data {
                        
                        do {
                            let okImage = UIImage(data: try Data(contentsOf: getURL))
                            DispatchQueue.main.async {
                                self.filmImageView.image = okImage
                                self.loadActivityIndicator.stopAnimating()
                            }
                        } catch {
                            DispatchQueue.main.async {
                                self.popAlert()
                            }
                            print(error.localizedDescription)
                        }
                    }
                }
                task.resume()
            }
            
        }
        
        filmNameLabel.text = film.filmName
        infoTableViewController?.directorLabel.text = film.director
        infoTableViewController?.genreLabel.text = film.genre
        infoTableViewController?.releaseDateLabel.text = film.releaseDate
    }
    
    func popAlert() {
        
        let alert = UIAlertController(title: "Something Wrong", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }

}

