//
//  ViewController.swift
//  Thirdparty
//
//  Created by Sahab Alharbi on 01/05/1443 AH.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let apiUrl = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "artPehUgn7N9v8i6boLuAbhriSIRWVdFMVUUqocc"
    let datePicker = UIDatePicker()
    let titleLabel = UILabel()
    let image = UIImageView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.maximumDate = Date()
        datePickerHandler((Any).self)
        setup()
        view.overrideUserInterfaceStyle = .dark
    }
    
        @objc func datePickerHandler(_ sender: Any){
                 let dateFormatter = DateFormatter()
                  dateFormatter.dateFormat = "yyyy-MM-dd"

                  let selectedDate = dateFormatter.string(from: datePicker.date)

                  requestImage(date: selectedDate)
             }
        func requestImage(date: String){
            let parameter : [String : String] = ["date": date]
            AF.request(apiUrl + apiKey, method: .get, parameters: parameter).responseJSON {
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

                    self.titleLabel.text = imageTitle

                    let imageURL = URL(string: image!)
                    let imageData =  try! Data(contentsOf: imageURL!)

                    self.image.image = UIImage(data: imageData)

                case .failure(let error):
                    print("Error: \(error)")


                }
            }
        }
    
    func setup() {
        
        
        // datePicker
        datePicker.frame = CGRect(x: 10, y: 60, width:200 , height: 200)
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.setValue(UIColor.black, forKey: "backgroundColor")
        datePicker.addTarget(self, action: #selector(datePickerHandler), for: .valueChanged)
        self.view.addSubview(datePicker)
        
        //titleLabel
        titleLabel.text = "Image from the space"
        titleLabel.textColor = .brown
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
        
        //image
        image.frame = CGRect(x: 10, y: 250, width: 365, height: 450)
        image.layer.cornerRadius = 20
        view.addSubview(image)
    }

}

