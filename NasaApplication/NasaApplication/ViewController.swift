//
//  ViewController.swift
//  NasaApplication
//
//  Created by Ahmad MacBook on 05/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageTitle: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    var apiKey = "0a4dru6VdmAgUqLvPhk38vexHfR4bvYpERPMQeZ7"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date()
        datePickerFunc((Any).self)
    }
    
    @IBAction func datePickerFunc(_ sender: Any) {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyy-MM-dd"
        
        let selectedDate = dateFormater.string(from: datePicker.date)
        
        requestImage(date: selectedDate)
    }
    
    func requestImage(date : String){
        let parameter : [String : String] = ["date" : date]
        AF.request( apiURL + apiKey , method: .get , parameters: parameter).responseJSON { response in
            
            switch response.result{
            case .success(let value ):
                print("JSON  \(value)")
                
                guard let response = value as? [String:String] else {
                    print("Error")
                    return
                }
                
                let imageTitle = response ["title"]
                let image = response["url"]
                
                self.imageTitle.text = imageTitle
                
                let imageURL = URL(string: image!)
                let imageData = try! Data(contentsOf: imageURL!)
                
                self.imageView.image = UIImage(data: imageData)
                
            case .failure(let error ):
                print("Error : \(error)")
            }
        }
        
    }
    
}




