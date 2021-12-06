
import UIKit
import Alamofire
class ViewController: UIViewController {


    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imageTitle: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY="
    let apiKey = "RxGD42dJfcXDmOK2SeansFKhJA4U0gfZbx5SRW6f"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date()
        datePickerHandler((Any).self)
        
    }
    @IBAction func datePickerHandler(_ sender: Any) {
    
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        requestImage(date: selectedDate)
    }
    func requestImage(date: String) {
        let parameter: [String : String] = ["date": date]
        AF.request( apiURL + apiKey, method: .get, parameters: parameter).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                print("JSON: \(value)")
                guard let response = value as? [String: String] else {
                    print("Error")
                    return
                }
                let imageTitle = response["Title"]
                let image = response["url"]
                self.imageTitle.text = imageTitle
                let imageURL = URL(string: image!)
                let imageData = try! Data(contentsOf: imageURL!)
                self.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                
                print("Error:\(error)")
            }
        }
        
    }
}

