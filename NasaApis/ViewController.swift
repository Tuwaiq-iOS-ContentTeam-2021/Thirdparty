

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var imagelabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let apiURl = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "B3XBH8NZCAccMddOGilayZubbie0DlBD6TeEkSw9"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datepicker.maximumDate = Date()
        Datebickeraction((Any).self)
    
    }

    @IBAction func Datebickeraction(_ sender: Any) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateformatter.string(from: datepicker.date)
        requestImage(date: selectedDate)
    }
    func requestImage(date : String){
        let parameters : [String:String] = ["date" : date]
        AF.request(apiURl+apiKey , method: .get , parameters: parameters).responseJSON {
            
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
                
                
                self.imagelabel.text = imageTitle
                
                let imageURL = URL(string: image!)
                let imageData =  try! Data(contentsOf: imageURL!)
                
                self.imageView.image = UIImage(data: imageData)
                
            case .failure(let error):
                print("Error \(String(describing: error))")
            }
        }
    }
}
