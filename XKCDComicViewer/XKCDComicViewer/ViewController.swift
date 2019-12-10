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
    
    var urlImage = "https://imgs.xkcd.com/comics/data_error.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        self.urlImage = urlString
        
        NetworkHelper.shared.performDataTask(with: urlImage) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }

    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
    }
}

