//
//  Grids.swift
//  APODapi
//
//  Created by Abdullah Alnutayfi on 05/12/2021.
//

import UIKit

class SavedImagesGrids: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var imagesCollectionView : UICollectionView? = nil
    var images : [UIImage]?

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
               layout.itemSize = CGSize(width: 100, height: 100)
        
        imagesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        imagesCollectionView!.backgroundColor = UIColor.white
        imagesCollectionView!.dataSource = self
        imagesCollectionView!.delegate = self
        imagesCollectionView!.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "coleectionViewCell")
        view.addSubview(imagesCollectionView!)

        NSLayoutConstraint.activate([
            imagesCollectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesCollectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            imagesCollectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            imagesCollectionView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView!.dequeueReusableCell(withReuseIdentifier: "coleectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.image.image = images![indexPath.row]
        cell.backgroundColor = .red
        return cell
    }
    
}
