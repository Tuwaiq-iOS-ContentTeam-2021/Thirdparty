//
//  ViewController.swift
//  AlamofireNasa
//
//  Created by loujain on 05/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "OaV3lsFdzrN7J10xN9SpmXB4K5gtT6pLTcGfR83j"

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        datePickerHandler((Any).self)
    }

    @IBAction func datePickerHandler(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
           requestImage (date: selectedDate)
    }
    func requestImage (date: String)   {
        
        let parameters : [String : String] = ["date": date]
        
        AF.request(apiURL + apiKey, method: .get, parameters: parameters)
            .responseJSON {

            response in
            
            switch response.result {
            
            case .success(let value):
                
                print("JSON: \(value)")
                guard let response = value as? [String: String] else {
                    print("Error..")
                    return
                }
                let imageTitle = response["title"]
                let image = response["url"]
                self.imageTitleLabel.text = imageTitle
                let imageURL = URL(string: image!)
                
                let imageData =  try! Data(contentsOf: imageURL!)
    
                self.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                
                print("JSON: \(error)")
                
                
            }
        }
    }
}

