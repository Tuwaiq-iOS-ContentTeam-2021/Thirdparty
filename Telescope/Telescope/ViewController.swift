//
//  ViewController.swift
//  Telescope
//
//  Created by esho on 01/05/1443 AH.
//

import UIKit
import Alamofire
import Lottie
class ViewController: UIViewController {

    var datePicker = UIDatePicker()
    let TitleLable = UITextView()
    let imageView = UIImageView()
    let dateLable = UILabel()
    let animationView = AnimationView()
    let animationView2 = AnimationView()
    let apiUrl = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "YgHlimbbOc5aNQCb3zHjTFNzkRPe6BCJzlsawc6i"
  

    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        //Animation Sky
        animationView.frame = CGRect(x: 0 , y: 0 , width: 450, height: 700)
        animationView.backgroundColor = .black
        animationView.animation = Animation.named("skynight")
                animationView.play()
                animationView.loopMode = .loop
        view.addSubview(animationView)
        
        
        //Animation Astronaut
        animationView2.frame = CGRect(x: 0, y: 350 , width: 500, height: 500)
        animationView.frame = view.bounds
        animationView2.animation = Animation.named("Astronaut")
                animationView2.loopMode = .loop
        animationView2.play()
        view.addSubview(animationView2)
        
        
        //Title
        TitleLable.text = "Telescope in space 🔭 "
        TitleLable.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)
        TitleLable.textColor = .white
        TitleLable.alpha = 1
        TitleLable.backgroundColor = .lightGray
        TitleLable.frame = CGRect(x: 40, y: 110, width: 300, height: 40)
        TitleLable.layer.cornerRadius = 20
        view.addSubview(TitleLable)
        
        
        //Date Title
        dateLable.text = "Select Date :"
        dateLable.textColor = .gray
        dateLable.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)
        dateLable.frame = CGRect(x: 50 , y: 170, width: 150, height: 40)
        view.addSubview(dateLable)
        
        
        //Date
        datePicker.frame = CGRect(x: 170, y: 175, width: 80, height: 30)
        datePicker.backgroundColor = .lightGray
        datePicker.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        datePicker.layer.borderWidth = 2
        datePicker.tintColor = .white
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerHandler) , for:.valueChanged)
        view.addSubview(datePicker)
        
        
        //image View Show the pic
        imageView.frame = CGRect(x: 5, y: 250, width: 400, height: 600)
        view.addSubview(imageView)


    }
    
    //Date formatte
    @objc func datePickerHandler() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        let selectDate = dateFormatter.string(from: datePicker.date)
        requestImage(date: selectDate)
    }
    
    @objc func requestImage (date : String){
        let parameter : [String:String] = ["date": date]
        AF.request(apiUrl + apiKey , method: .get, parameters: parameter).responseJSON {
            response in

            switch response.result {
            case .success(let value):
                print("JSON: \(value)")
                guard let response = value as? [String:String] else {
                    print("error1")
                    return
                }
                let  imageTitle = response["title"]
                let image = response["url"]

                self.TitleLable.text = imageTitle

                let imageUrl = URL(string: image!)
                let imageData = try! Data(contentsOf: imageUrl!)

                self.imageView.image = UIImage(data: imageData)

            case.failure(let error):
                print("error2: \(error)")
            }
        }
    }

}

  
