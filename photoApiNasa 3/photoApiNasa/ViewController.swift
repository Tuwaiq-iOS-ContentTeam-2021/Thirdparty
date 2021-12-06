//
//  ViewController.swift
//  photoApiNasa
//
//  Created by Abrahim MOHAMMED on 05/12/2021.
//

import UIKit

import Alamofire



class ViewController: UIViewController {

    @IBOutlet weak var NamePhotoLable: UILabel!
    
    @IBOutlet weak var pikerOutLetLable: UIDatePicker!
    
    @IBOutlet weak var imageOutLetLable: UIImageView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    
    let apiKey = "ok2l96kb25F2Q5huKXVNXhoe8byf7E7XGUKUluYm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pikerOutLetLable.maximumDate = Date()
        
        pikerAcation((Any).self)
            
            
    }
    
    

    @IBAction func pikerAcation(_ sender: Any) {
        
        let dataFormatter = DateFormatter()
        
        dataFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dataFormatter.string(from: pikerOutLetLable.date)
        
        requstImage(date: selectedDate)
        
    }
    
    func requstImage(date:String){
        let parameter: [String: String] = ["date": date]
                AF.request(apiURL + apiKey, method: .get, parameters: parameter).responseJSON { response in
                    
                    switch response.result {
                        
                    case .success(let value):
                        
                     print("JSON: \(value)")
                        
                        guard let response = value as? [String:String] else {
                            print("Error")
                            
                            return
                        }
                        
                        let imageTitle = response ["title"]
                        let image = response ["url"]
                        
                        self.NamePhotoLable.text = imageTitle
                        
                        let imageURL = URL(string: image!)
                        let imageData = try! Data(contentsOf: imageURL!)
                        
                        self.imageOutLetLable.image = UIImage(data: imageData)
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }


        
        
    }
    
}

