//
//  ViewController.swift
//  Nasa-API-Project
//
//  Created by Badreah Saad on 06/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
        
    @IBOutlet weak var selectedDate: UIDatePicker!
    
    @IBOutlet weak var imageTitle: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "uAGjMHgLUz4QHJNdo8DgfIUAOPumNA7mQ8vGwToB"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedDate.maximumDate = Date()
        selectedDate((Any).self)
    }
    
    
    @IBAction func selectedDate(_ sender: Any) {
        
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        
        let dateSelected = date.string(from: selectedDate.date)
        
        selectedDateImage(date: dateSelected)
    }
    
    func selectedDateImage(date: String) {
        
        let parameters: [String: String] = ["date": date]
        
        AF.request(apiURL + apiKey, method: .get, parameters: parameters)
            .responseJSON {
                
                response in
                
                switch response.result {
                case .success(let value):
                    print("JSON: \(value)")
                    
                    guard let response = value as? [String: String] else {
                        print("Error")
                        return
                    }
                    
                    let imageTitle = response["title"]
                    let image = response["url"]
                    
                    self.imageTitle.text = imageTitle
                    
                    let imageURL = URL(string: image!)
                    let imageData = try! Data(contentsOf: imageURL!)
                    
                    self.myImage.image = UIImage(data: imageData)
                    
                case .failure(let error):
                    print("error \(String(describing: error))")
                }
                
            }
    }
    
}
