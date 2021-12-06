//
//  ViewController.swift
//  NasaPicture
//
//  Created by Wejdan Alkhaldi on 02/05/1443 AH.
//
import Alamofire
import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imageTitleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "BRPW8Ul4YFUDDoFo10HBG011faJZ4zFnBCx84WcJ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        datePickerHandler((Any).self)
       
    }

    @IBAction func datePickerHandler(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dateFormatter.string(from: datePicker.date)
        requestImage(date: selectedDate)
    }
    
    func requestImage(date: String) {
        let parameter : [String : String] = ["date" : date]
        AF.request(apiURL + apiKey, method: .get, parameters: parameter).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                print("JSON: \(value)")
                guard let response = value as? [String:String] else {
                    print("Error")
                    return
                }
                let imageTitle = response["title"]
                let image = response["url"]
                self.imageTitleLabel.text = imageTitle
                let imageURL = URL(string: image!)
                let imageDate = try! Data (contentsOf: imageURL!)
                self.imageView.image = UIImage(data: imageDate)
           
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
}


