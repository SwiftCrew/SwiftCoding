//
//  APIInViewController.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class APIInViewController: UIViewController {
    let baseUrl : String = "https://haveibeenpwned.com/api/v2"
    let breachesExtensionURL : String = "/breaches"

    @IBOutlet weak var dataDownloadedLabel: UILabel!
    
    var dataDownloaded = 0 {
        didSet {
            DispatchQueue.main.async(execute: {  [weak self] () -> Void in
                guard let self = self else {return}
                self.dataDownloadedLabel.text = "Data items downloaded : \(self.dataDownloaded)"
            }
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func apiAction(_ sender: UIButton) {
        makeAPICall()
    }
    
    func makeAPICall() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: baseUrl + breachesExtensionURL)
        let task = session.dataTask(with: url!) { [weak self] (data, response, error) in
            guard let self = self else {return}
            if let data = data{
                self.dataDownloaded += data.count
            }
        }
        task.resume()
    }
    
}
