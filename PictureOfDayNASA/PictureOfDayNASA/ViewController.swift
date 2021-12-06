//
//  ViewController.swift
//  PictureOfDayNASA
//
//  Created by mac on 06/12/2021.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var displayTitlePicLable: UILabel!
    
    @IBOutlet weak var NASAImage: UIImageView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "dGVa6RwFMR2Wqi0K6cfnxXcYWeNI5n2hkJwcccjq"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date()
        datePickerAction((Any).self)

    }

    @IBAction func datePickerAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        requestImage(date: selectedDate)
    }
    
    
    func requestImage(date: String) {
        let perameter: [String:String] = ["date": date]
        AF.request(apiURL + apiKey, method: .get, parameters: perameter).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                print("JSON: \(value)")
                
                guard let response = value as? [String:String] else {
                    print("error")
                    return
                }
                let imageTitle = response["title"]
                let image = response["url"]
                
                self.displayTitlePicLable.text = imageTitle
                
                let imageURL = URL(string: image!)
                let imageData = try! Data(contentsOf: imageURL!)
                
                self.NASAImage.image = UIImage(data: imageData)
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
}

