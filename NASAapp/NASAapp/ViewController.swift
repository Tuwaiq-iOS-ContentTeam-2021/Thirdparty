//
//  ViewController.swift
//  NASAapp
//
//  Created by TAGHREED on 01/05/1443 AH.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var imageLable: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "hDGkFGblYnvqaGsBDdGJi8CdTVrXMJmTDwffdaLf"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        datePickerHandler((Any).self)
        datePicker.layer.cornerRadius = 20
        
    }
    
    @IBAction func datePickerHandler(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        requestImage(date: selectedDate)
        
    }
    
    
    func requestImage (date: String){
        
        let parameters : [String:String] = ["date":date]
        AF.request(apiURL + apiKey, method: .get, parameters: parameters)
            .responseJSON {
                response in
                
                switch response.result {
                    
                case .success(let value):
                    print("JSON:\(value)")
                    
                    guard let response = value as? [String: String] else {
                        print("Error..")
                        return
                    }
                    
                    let imageTitle = response ["title"]
                    self.imageLable.text = imageTitle
                    
                    let image = response ["url"]
                    let imageURL = URL(string: image!)
                    let imageData = try! Data(contentsOf: imageURL!)
                    
                    
                    self.img.image = UIImage(data: imageData)
                    
                    
                    
                case .failure(let error):
                    print("error:\(error)")
                    
                }
            }
    }
    
}

