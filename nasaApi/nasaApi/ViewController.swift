//
//  ViewController.swift
//  nasaApi
//
//  Created by Qahtani's MacBook Pro on 12/5/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
  
    var mylabel = UILabel()
    var screenW = UIScreen.main.bounds.size.width
    var screenH = UIScreen.main.bounds.size.height
    
    var mylabel2 = UILabel()
    var mybutton = UIButton()
    var myimage = UIImageView()
    var datePicker = UIDatePicker()
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "9F76sp6vjJgc432qPqlCfTyv5OIaedQmndKaYZFa"
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mylabel.frame = CGRect(x: self.screenW / 18, y: screenH / 4.50, width: 330, height: 30)
    
        mylabel.backgroundColor = .gray
        mylabel.layer.borderColor = UIColor.gray.cgColor
        mylabel.layer.borderWidth = 2
        mylabel.text =  "  صور وكالة ناسا "
        mylabel.textAlignment = .center
        mylabel.textColor = .black
        view.addSubview(mylabel)
        mylabel2.frame = CGRect(x: self.screenW / 1.55, y: screenH / 6, width: 100, height: 30)
        mylabel2.backgroundColor = .cyan
        mylabel2.textAlignment = .center
        mylabel2.layer.cornerRadius = 5
        mylabel2.layer.borderWidth = 2
        
        mylabel2.layer.borderColor = UIColor.cyan.cgColor
        mylabel2.text = "حدد  التاريخ"
        
        mylabel2.textColor = .black
        view.addSubview(mylabel2)
        
        myimage.frame = CGRect(x: self.screenW / 20, y: screenH / 3.50, width: screenW - 50, height: screenW - 50)
        myimage.image = UIImage.init(named: "xcod")
        view.addSubview(myimage)
        
        datePicker.frame = CGRect(x: self.screenW / 18, y: screenH / 6, width: 115, height: 30)
        datePicker.datePickerMode = .date
        view.addSubview(datePicker)
        dateDay()
        
        mybutton.frame = CGRect(x: screenW / 2.60, y: screenH / 1.40, width: 115, height: 40)
        mybutton.setTitle("button", for: .normal)
        mybutton.setTitleColor(.black, for: .normal)
        mybutton.layer.cornerRadius = 20
        mybutton.backgroundColor = .green
        mybutton.addTarget(self.self, action: #selector(dateDay), for: .touchUpInside)
        view.addSubview(mybutton)
        
}
    
  
    
    
   @objc func dateDay(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
    
        let selectedDate = dateFormatter.string(from: datePicker.date)
        requestImage(date: selectedDate)
        
    }
    func requestImage(date: String){
        let parameters : [String : String] = ["date": date]

        //العنوان الذي يتم استدعاءه
        AF.request( apiURL + apiKey, method: .get, parameters: parameters).responseJSON {
            response in
            switch response.result{
            case .success(let value):
                print("JSON: \(value)")
                guard let response = value as? [String:String] else {
                    print("Error")
                    return
                    
                }
                let imageTitle = response["title"]
                   let image = response["url"]
                self.mylabel.text = imageTitle
                
                let imageURL = URL(string: image!)
                let imageData =  try! Data(contentsOf: imageURL!)
                self.myimage.image = UIImage(data: imageData)

                
                
        
                
            case .failure(let error):
                print("Error:\(error)")
                
            }
        }
    }
}
