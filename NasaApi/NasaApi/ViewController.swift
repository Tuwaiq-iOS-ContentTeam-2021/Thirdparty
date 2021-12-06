//
//  ViewController.swift
//  NasaApi
//
//  Created by Abdullah AlRashoudi on 12/6/21.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var nasaImage: UIImageView!
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "XAWQ83MWIFEbZsC9eErz8zcEgomdClbx6pT51jmc"
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
        let parameter: [String: String] = ["date": date]
        AF.request(apiURL + apiKey, method: .get, parameters: parameter).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
             print("JSON: \(value)")
                
                guard let response = value as? [String:String] else {
                    print("Error")
                    
                    return
                }
                
                let imageTitle = response ["title"]
                let image = response ["url"]
                
                self.imageName.text = imageTitle
                
                let imageURL = URL(string: image!)
                let imageData = try! Data(contentsOf: imageURL!)
                
                self.nasaImage.image = UIImage(data: imageData)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

