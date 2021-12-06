//
//  ViewController.swift
//  NASAAPI
//
//  Created by Nora on 02/05/1443 AH.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    let mainLebel = UILabel()
    let datePic = UILabel()
    let date = UIDatePicker()
    let imgTitle = UILabel()
    let nasaImg = UIImageView()
    
    let apiUrl = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "VG9gcLBUpFWHKbSvPWZPmULcgvyVeDtl0qxYhK8Z"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLebel.frame = CGRect(x: 130, y: 100, width: 100, height: 20)
        mainLebel.textColor = .black
        mainLebel.text = "NASA"
        mainLebel.font = .systemFont(ofSize: 20)
        view.addSubview(mainLebel)
        
        datePic.frame = CGRect(x: 330, y: 170, width: 100, height: 20)
        datePic.textColor = .black
        datePic.text = "Chose a date"
        datePic.font = .systemFont(ofSize: 20)
        
        
        
        date.frame = CGRect(x: 30, y: 170, width: 200, height: 50)
        //        date.calendar = .current
        //        date.timeZone = .autoupdatingCurrent
        date.maximumDate = Date()
        date.tintColor = .black
        date.addTarget(self, action: #selector(dateHandler), for: .allEvents)
        date.datePickerMode = .date
        view.addSubview(date)
        
        imgTitle.frame = CGRect(x: 150, y: 250, width: 200, height: 20)
        imgTitle.textColor = .black
        imgTitle.text = "image title"
        imgTitle.font = .systemFont(ofSize: 15)
        view.addSubview(imgTitle)
        
        nasaImg.frame = CGRect(x: 48, y: 300, width: 300, height: 400)
        //        nasaImg.image = UIImage(systemName: "heart")
        view.addSubview(nasaImg)
        
        
        view.backgroundColor = .white
    }
    
    
    @objc func dateHandler() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dateFormatter.string(from: date.date)
        
        imageRecived(date: selectedDate)
    }
    
    func imageRecived(date: String) {
        let parameters : [String : String] = ["date": date]
        AF.request(apiUrl + apiKey, method: .get, parameters: parameters)
            .responseJSON {  response in
                
                switch response.result {
                case .success(let value):
                    print("JSON: \(value)")
                    
                    guard let response = value as? [String:String] else {
                        print("Error")
                        
                        return
                    }
                    
                    let imageTitle = response["title"]
                    let image = response["url"]
                    
                    self.imgTitle.text = imageTitle
                    
                    let imageURl = URL(string: image!)
                    let imageData = try! Data(contentsOf: imageURl!)
                    
                    self.nasaImg.image = UIImage(data: imageData)
                    
                case .failure(let error):
                    print("Error \(error)")
                }
                
                
            }
        
    }
    
}
