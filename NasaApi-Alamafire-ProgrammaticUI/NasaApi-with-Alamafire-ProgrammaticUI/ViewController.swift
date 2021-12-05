//
//  ViewController.swift
//  NasaApi-with-Alamafire-ProgrammaticUI
//
//  Created by WjdanMo on 05/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let pageTitle = UILabel()
    let chooseADateLabel = UILabel()
    let datePicker = UIDatePicker()
    let imageTitleLabel = UILabel()
    let imageView = UIImageView()
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "Dx1fFo58A4H5tth0RmBzrqiuyeo5dAVvv5TwEmDC"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.overrideUserInterfaceStyle = .dark
        
        datePickerHandler((Any).self)
        
        setupObjects()
        
    }
    
    @objc func datePickerHandler(_ sender: Any){
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         
         let selectedDate = dateFormatter.string(from: datePicker.date)
         
         requestImage(date: selectedDate)
    }
    
    func requestImage(date: String){
        let parameter : [String : String] = ["date": date]
        
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
                let  imageData = try! Data(contentsOf: imageURL!)
                
                self.imageView.image = UIImage(data: imageData)
                
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                
                
            }
        }
    }
    
    
    func setupObjects(){
        
        // Label Setup
        pageTitle.text = "A look from Far away 🪐"
        pageTitle.textColor = .white
        pageTitle.textAlignment = .center
        pageTitle.frame = CGRect(x: 0, y: view.frame.height/6, width: view.frame.width, height: 40)
        pageTitle.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        view.addSubview(pageTitle)
        
        
        // Label Setup
        chooseADateLabel.text = "Choose a date :"
        chooseADateLabel.textColor = .white
        chooseADateLabel.textAlignment = .left
        chooseADateLabel.frame = CGRect(x: view.frame.width/7, y: view.frame.height/4, width: view.frame.width/2, height: 40)
        chooseADateLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        view.addSubview(chooseADateLabel)
        
        
        // DatePicker Setup
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerHandler), for: .valueChanged)
        datePicker.backgroundColor = .clear
        datePicker.textColor = UIColor.white
        datePicker.setValue(false, forKeyPath: "textColor")
        datePicker.frame = CGRect(x: view.frame.width/3, y: view.frame.height/4, width: view.frame.width/2, height: 40)
        view.addSubview(datePicker)
        
        
        // Image title label - from API
        imageTitleLabel.text = "Choose a date :"
        imageTitleLabel.textColor = .white
        imageTitleLabel.textAlignment = .center
        imageTitleLabel.frame = CGRect(x: 0 , y: view.frame.height/3, width: view.frame.width, height: 40)
        imageTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        view.addSubview(imageTitleLabel)
        
        
        // ImageView Setup
        imageView.frame = CGRect(x: 0, y: view.frame.height/2.5, width: view.frame.width, height: view.frame.height-view.frame.width)
        imageView.layer.cornerRadius = 6
        view.addSubview(imageView)
        
    }


}

extension UIDatePicker {

     var textColor: UIColor? {
         set {
              setValue(newValue, forKeyPath: "textColor")
             }
         get {
              return value(forKeyPath: "textColor") as? UIColor
             }
     }

     var highlightsToday : Bool? {
         set {
              setValue(newValue, forKeyPath: "highlightsToday")
             }
         get {
              return value(forKey: "highlightsToday") as? Bool
             }
     }
 }

