//
//  ViewController.swift
//  NasaAPI
//
//  Created by Najla Talal on 12/6/21.
//

import UIKit
import Alamofire
import SwiftUI
class ViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imageTitleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "os5Fmn8AXruMkMSFDDiVG3RkYdoNGyeiKTy0LgAn"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date()
        datePickerHandler((Any).self)
        imageTitleLabel.font = UIFont(name: "GillSans-Italic", size: 20)
        
    }
    
    @IBAction func datePickerHandler(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        requestImage (date: selectedDate)
    }
    
    func requestImage (date: String) {
        
        
        let parameters : [String : String] = ["date": date]
        
        AF.request(apiURL + apiKey, method: .get, parameters: parameters)
            .responseJSON {
                
                response in
                
                
                switch response.result {
                    
                case .success(let value):
                    
                    
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
    
}




