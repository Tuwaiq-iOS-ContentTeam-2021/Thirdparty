//
//  ViewController.swift
//  nasaCocopod
//
//  Created by Areej on 02/05/1443 AH.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var titleImageLable: UILabel!
    @IBOutlet weak var imageNasa: UIImageView!
    
    let apiURL = "https://api.nasa.gov"
    let apiKey = "46QBAmswJA5ThxhHx4m8nHW1NDhkDtQMitgsKPpn"
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.maximumDate = Date()
        dataPickerHandler(Any.self)
        // Do any additional setup after loading the view.
    }
    @IBAction func dataPickerHandler(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let selectedDate = dateFormatter.string(from: dataPicker.date)
        requestImage(date: selectedDate)
    }
    func requestImage(date: String){
        let parameter :[String:String] = ["date": date]
        AF.request(apiURL + apiKey, method: .get, parameters: parameter).responseJSON { response in
            
            switch response.result{
            case.success(let value):
                print ("Jason: \(value)")
                guard let response = value as? [String:String] else {
                    print("ERROR")
                    return
                    
                }
                
                let imageTitle = response["title"]
                let image = response["url"]
                
                self.titleImageLable.text = imageTitle
                
                let imageURL = URL(string: image!)
                let imageData = try! Data(contentsOf: imageURL!)
                
                self.imageNasa.image = UIImage(data: imageData)
                
            case.failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }

}

