//
//  ViewController.swift
//  NasaAstro
//
//  Created by Lola M on 12/5/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    let api = "https://api.nasa.gov/planetary/apod?api_key=o20zSzUDlaKV1JLFWlFV9WIdZ7wF9flF60myndmY"
    let whiteSquare = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width
        let height = view.frame.height
        
        //whiteSquare
        view.addSubview(whiteSquare)
        whiteSquare.frame = CGRect(x: 0, y: height-height/4-height/8, width: width, height: height/5)
        whiteSquare.backgroundColor = UIColor(white: 1, alpha: 0.4)
        view.bringSubviewToFront(whiteSquare)
        datePickerOutlet.superview?.bringSubviewToFront(datePickerOutlet)

        
        //datePicker
        datePickerOutlet.maximumDate = Date()
        datePickerAction((Any).self)
        datePickerOutlet.timeZone = NSTimeZone.local
        
        datePickerOutlet.frame = CGRect(x: 0, y: height-height/4-height/8, width: width, height: height/5)
        datePickerOutlet.preferredDatePickerStyle = .wheels
        datePickerOutlet.datePickerMode = .date
        whiteSquare.bringSubviewToFront(datePickerOutlet)
        

    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dateFormatter.string(from: datePickerOutlet.date)
        RequestImage(date: selectedDate)
    }
    
    
    func RequestImage(date: String) {
        
        let parameters : [String : String] = ["date": date]
        
        AF.request(api, method: .get, parameters: parameters)
            .responseJSON {

            response in
            
            switch response.result {
            
            case .success(let value):
                
                print("JSON: \(value)")
                
                guard let response = value as? [String: String] else {
                    print("Error..")
                    return
                }
                
                let imageTitle = response["title"]
                let image = response["url"]
                
                
                self.titleOutlet.text = imageTitle
                
                let imageURL = URL(string: image!)
                let imageData =  try! Data(contentsOf: imageURL!)
                
                self.imageView.image = UIImage(data: imageData)
                
            case .failure(let error):
                print("Error \(String(describing: error))")
            }
        }
    }
}

