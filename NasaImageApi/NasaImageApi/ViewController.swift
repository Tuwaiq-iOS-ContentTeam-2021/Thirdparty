//
//  ViewController.swift
//  NasaImageApi
//
//  Created by Rayan Taj on 05/12/2021.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var image: UIImageView!
    
    let apiUrl = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "YaAzPb64TZmP349jhUM4hagr5IPzFib1C9rnsx8K"
    
   
    
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        datePicker.maximumDate = Date()
        dateChanged((Any).self)
    }
    
    
    
    @IBAction func dateChanged(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        
        
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        requestImage(date: selectedDate)
    }
    
    
    func requestImage(  date: String  )  {
        
        let parameters : [String : String] = ["date": date]
        
        AF.request(apiUrl + apiKey, method: .get, parameters: parameters)
            .responseJSON {

            response in
            
            switch response.result {
            
            case .success(let value):
                
                print("Json file String : \(value)")
                
                guard let response = value as? [String: String] else {
                    print("Error..")
                    return
                }
                
              
                let title = response["title"]
                self.titleLabel.text = title
                
                
                let image = response["url"]
                let imageURL = URL(string: image!)
                let imageData =  try! Data(contentsOf: imageURL!)
                
                self.image.image = UIImage(data: imageData)
                
            case .failure(let error):
                print("Error in requestImage \(error)  ")
            }
        }
    }
    
    
    
    
}

