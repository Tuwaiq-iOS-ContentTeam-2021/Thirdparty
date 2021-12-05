
import UIKit
import Alamofire

class ViewController: UIViewController {
    var visitedImages : [UIImage] = []
    var savedImages : UIButton = {
       // $0.addTarget(self, action: #selector(moveToGrids), for: .touchDown)
        $0.setTitle("Images you have visited", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    let apiKey = "EQZwTLS1ujm6vPoli5CTqJlcB9VGYam7G7YScHtg"
    lazy var dataPicker : UIDatePicker = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.maximumDate = Date()
        $0.addTarget(self, action: #selector (changeDate), for: .valueChanged)
        return $0
    }(UIDatePicker())
    
    lazy var appTitle : UILabel = {
        $0.text = "Image from the space"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var dateLable : UILabel = {
        $0.text = "Select the date"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    lazy var imageCaption : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UILabel())
    
    lazy var imgView : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    override func viewDidLoad() {
        uiSetup()
        changeDate()
    }
    @objc func changeDate(){
        let selectedDate = dateFormatter.string(from: dataPicker.date)
       _ = fetchData(date : selectedDate)
        visitedImages.append(fetchData(date : selectedDate))
        print(visitedImages.count)
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter
    }()
    
    func uiSetup(){
        [appTitle, dateLable,
         imageCaption,imgView,dataPicker].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
//            savedImages.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
//            savedImages.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            savedImages.leadingAnchor.constraint(equalTo: view.leadingAnchor),

        
            appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dataPicker.topAnchor.constraint(equalTo: appTitle.bottomAnchor,constant: 40),
            dataPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            
            dateLable.topAnchor.constraint(equalTo: appTitle.bottomAnchor,constant: 40),
            dateLable.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            dateLable.centerYAnchor.constraint(equalTo: dataPicker.centerYAnchor),
            
            
            imgView.topAnchor.constraint(equalTo: dataPicker.bottomAnchor,constant: 40),
            imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 350),
            imgView.widthAnchor.constraint(equalToConstant: 200),
            
            imageCaption.topAnchor.constraint(equalTo: imgView.bottomAnchor,constant: 20),
            imageCaption.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCaption.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCaption.centerXAnchor.constraint(equalTo: imgView.centerXAnchor),
       
])
    }
    func fetchData(date : String) -> UIImage{
        var imageAsURL : URL?
        var imageAsData =  Data()
        let parameters : [String : String] = ["date": date]
        AF.request(apiURL + apiKey, method: .get, parameters: parameters)
            .responseJSON {
            response in
            switch response.result {
            case .success(let value):
                print("JSON: \(value)")
                guard let response = value as? [String: String] else {
                    return
                }
                let imageCaption = response["title"]
                let image = response["url"]
                self.imageCaption.text = imageCaption
                 imageAsURL = URL(string: image!)
                 imageAsData =  try! Data(contentsOf: imageAsURL!)
                
                self.imgView.image = UIImage(data: imageAsData)
            case .failure(let error):
                print("Error \(error as Any)")
            }
        }
        return UIImage(data: imageAsData) ?? UIImage()
    }
    
//    @objc func moveToGrids(){
//        let grid = SavedImagesGrids()
//        grid.images = visitedImages
//        self.present(grid, animated: true, completion: nil)
//    }
//
}


