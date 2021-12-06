//
//  ViewController.swift
//  NASA
//
//  Created by Mola on 05/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    let myLabel = UILabel()

    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "dTh44A3vP9yPU5P4jl6c3aIXvoHKVPCx4vTgin3s"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myLabel.frame = CGRect(x: 90, y: 60, width: 200, height: 50)
        myLabel.font = UIFont(name: "GillSans-Italic", size: 35)
        myLabel.text = "Trip to space"
        myLabel.textColor = .white
        myLabel.backgroundColor = #colorLiteral(red: 0.05317718536, green: 0.08340347558, blue: 0.1913904548, alpha: 1)
        myLabel.textAlignment = .center
        view.addSubview(myLabel)
        
        datePicker.maximumDate = Date()
        datePickerHandler((Any).self)
        
    }
    
    @IBAction func datePickerHandler(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dateFormatter.string(from: datePicker.date)
        requestImage (date: selectedDate)
    }
    
    func requestImage (date: String) {
        let parameters : [String : String] = ["date": date]
        
        AF.request(apiURL + apiKey, method: .get, parameters: parameters).responseJSON {
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
                self.imageLabel.text = imageTitle
                let imageURL = URL(string: image!)
                let imageData =  try! Data(contentsOf: imageURL!)
                self.image.image = UIImage(data: imageData)
            
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
