//
//  ViewController.swift
//  Alamofire
//
//  Created by Um Talal 2030 on 05/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var imageTitel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "hslFUfkB9c1H8AVwLDZMiEmfULAaE1sw87PBRY3e"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        
        datePickerHandler((Any).self)
        
    }

    @IBAction func datePickerHandler(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //Convert data type from Date to String
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        //Call the function that is responsible for API
           requestImage (date: selectedDate)
    }
    
}
func requestImage (date: String) {
    
    
    let parameters : [String : String] = ["date": date]
    
    AF.request(apiURL + apiKey, method: .get, parameters: parameters)
        .responseJSON {

        response in
        
        
        switch response.result {
        
        case .success(let value):
            
            //Show response
            print("JSON: \(value)")
            
            //Save the response in dictionary
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
            print("Error \(String(describing: error))")
        }
    }
}



