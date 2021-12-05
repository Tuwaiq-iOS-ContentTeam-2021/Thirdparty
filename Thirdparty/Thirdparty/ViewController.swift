//
//  ViewController.swift
//  Thirdparty
//
//  Created by Ebtesam Alahmari on 05/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    
    @IBOutlet weak var imageTitleLbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "lEPYOJeqrw1LR0f08a0jIU3bFSEAZEigNDHgOrG2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        datePickerHandler((Any).self)
    }

    @IBAction func datePickerHandler(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: datePicker.date)
        
        requestImage(date: date)
    }
    
    func requestImage(date: String) {
        let parameter : [String:String] = ["date": date]
        AF.request(apiURL + apiKey, method: .get , parameters: parameter).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("JSON: \(value)")
                
                guard let response = value as? [String: String] else {
                    print("Error..")
                    return
                }
                
                let imageTitle = response["title"]
                let image = response["url"]
                
                
                self.imageTitleLbl.text = imageTitle
                
                let imageURL = URL(string: image!)
                let imageData =  try! Data(contentsOf: imageURL!)
                
                self.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}

