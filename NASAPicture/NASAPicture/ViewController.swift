//
//  ViewController.swift
//  NASAPicture
//
//  Created by Aisha Al-Qarni on 06/12/2021.
//

import UIKit
//import 

class ViewController: UIViewController {
let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "CLR0BsOxQTYhPlLVfTm9dVcbx8it0zY5CQLjHb73"
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imgTitle: UILabel!
    @IBOutlet weak var NasaImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        NASAdatePicker((Any).self)
    }

    @IBAction func NASAdatePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        let selectDate = dateFormatter.string(from: datePicker.date)
        requestImg(date: selectDate)
    }
    func requestImg(date: String){
        let parameter: [String:String] = ["date":date]
        AF.Request(apiURL+apiKey method: .get, parameter: parameter).responseJSON{
            
        }
    
    }
}

