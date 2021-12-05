//
//  ViewController.swift
//  day5_week9.3
//
//  Created by AlDanah Aldohayan on 05/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var imgDate: UIDatePicker!
    @IBOutlet weak var imgTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "pcYKaVH1BPBAxov0Lq7KBEalkSYCaGegeAIyL1WI"
    override func viewDidLoad() {
        super.viewDidLoad()
        imgDate.maximumDate = Date()
        dateAction((Any).self)
    }

    @IBAction func dateAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = dateFormatter.string(from: imgDate.date)
        
        requestImg(date: selectedDate)
    }
    
    func requestImg(date: String) {
        let parameter: [String: String] = ["date": date]
        AF.request(apiURL + apiKey, method: .get, parameters: parameter).responseJSON { response in
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
                
                let imageURL = URL(string: image!)
                let imageData = try! Data(contentsOf: imageURL!)
                
                self.imgView.image = UIImage(data: imageData)
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}

