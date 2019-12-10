//
//  ViewController.swift
//  XKCDComicViewer
//
//  Created by Brendon Cecilio on 12/6/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var comicStepper: UIStepper!

    var comicDetail = [ComicBooks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        textField.delegate = self
        loadData(issue: 614)
    }
    
    func loadData(issue: Int) {
        
        _ = ComicBookAPI.getComics(with: issue) { [weak self](result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let comics):
                DispatchQueue.main.async {
                    self?.textField.text = comics.num.description
                    self?.getImage(urlImage: comics.img)
                }
            }
        }
    }
    
    func getImage(urlImage: String) {
        NetworkHelper.shared.performDataTask(with: urlImage) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let data):
                DispatchQueue.main.async {
                let comicImage = UIImage(data: data)
                self?.imageView.image = comicImage
                }
            }
        }
    }

    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
    }
}

