//
//  ViewController.swift
//  NASA
//
//  Created by Taraf Bin suhaim on 01/05/1443 AH.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let titleLabel = UILabel(frame: CGRect(x: 20, y: 80, width: 350, height: 30))
    let date = UILabel(frame: CGRect(x: 40, y: 150, width: 350, height: 30))
    let datePicker = UIDatePicker(frame: CGRect(x: -100, y: 150, width: 350, height: 30))
    let imageTitle = UILabel(frame: CGRect(x: 20, y: 230, width: 380, height: 30))
    let imageView = UIImageView(frame: CGRect(x: 10, y: 280, width: 390 , height:  600))
    
    let apiUrl = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "jJlZK09FH7gIo4pgNXRVfdTYObnQVKbxbomojtB7"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9507612586, green: 1, blue: 0.9050489068, alpha: 1)
        
        titleLabel.setUpLabel("صورة من الفضاء",#colorLiteral(red: 0.9507612586, green: 1, blue: 0.9050489068, alpha: 1) , 20, .bold, .center)
        view.addSubview(titleLabel)
        
        date.setUpLabel("حدد التاريخ :", #colorLiteral(red: 0.9507612586, green: 1, blue: 0.9050489068, alpha: 1), 20, .medium, .right)
        view.addSubview(date)
        
        datePicker.addTarget(self, action: #selector (datePickerFormatter) , for: .valueChanged)
        view.addSubview(datePicker)
        
        imageTitle.backgroundColor = #colorLiteral(red: 0.9507612586, green: 1, blue: 0.9050489068, alpha: 1)
        view.addSubview(imageTitle)
        
        imageView.image = UIImage(named: "No")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        datePicker.maximumDate = Date()
        datePickerFormatter((Any).self)
    }
    
    @objc func datePickerFormatter (_ : Any){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        requstImage(selectedDate)
    }
    
    func requstImage(_ date:String){
        let dic : [String:String] = ["date": date]
        AF.request(apiUrl+apiKey, method: .get, parameters: dic).responseJSON {  response in
            
            switch response.result {
                
            case .success(let value):
                print("JSON:\(value)")
                
                guard let response = value as? [String:String] else {
                    print("Error")
                    return
                }
                
                let imageTitle = response["title"]
                let image = response["url"]
                self.imageTitle.text = imageTitle
                let imageURL = URL(string: image!)
                let imageData =  try! Data(contentsOf: imageURL!)
                self.imageView.image = UIImage(data: imageData)
                
            case.failure(let error):
                print("Erorr\(error)")
            }
        }
    }
}

extension UILabel {
    func setUpLabel(_ titleOfText : String , _ color:UIColor ,_ sizeOfText:CGFloat ,_ widthOfText:UIFont.Weight , _ textAlign:NSTextAlignment){
        text = titleOfText
        backgroundColor = color
        font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: sizeOfText , weight: widthOfText ))
        textAlignment = textAlign
    }
}
