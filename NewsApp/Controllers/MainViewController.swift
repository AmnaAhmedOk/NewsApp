//
//  ViewController.swift
//  NewsApp
//
//  Created by Amna on 11/18/20.
//  Copyright © 2020 Amna. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    var articles = [AnyObject]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkOperations.shared.performAPIRequset(urlString: "https://newsapi.org/v2/everything?q=egypt&apiKey=ea476aa57e7d47dcbd3098afb1983bbd"){
            print("finishhhh")
            DispatchQueue.main.async{
                self.articles = GlobalVariables.shared.egyptArticales
                print( self.articles.count)
                
                self.collectionView.reloadData()
                
            }
        }
        NetworkOperations.shared.performAPIRequset(urlString: "https://newsapi.org/v2/everything?q=apple&apiKey=ea476aa57e7d47dcbd3098afb1983bbd"){
        }
        NetworkOperations.shared.performAPIRequset(urlString: "https://newsapi.org/v2/everything?q=bitcoins&apiKey=ea476aa57e7d47dcbd3098afb1983bbd"){}
        NetworkOperations.shared.performAPIRequset(urlString: "https://newsapi.org/v2/everything?q=sports&apiKey=ea476aa57e7d47dcbd3098afb1983bbd"){}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        let nilCell = UINib(nibName: "ArticalCollectionViewCell", bundle: nil)
        collectionView.register(nilCell, forCellWithReuseIdentifier: "customCell")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        
    }
    
    
    
    @IBAction func didChangeSegemnet(_ sender: UISegmentedControl) {
      

        switch sender.selectedSegmentIndex {
            
        case 0:
            self.articles = GlobalVariables.shared.egyptArticales
            self.collectionView.reloadData()
        case 1:
            self.articles = GlobalVariables.shared.sportArticales
            self.collectionView.reloadData()
        case 2:
            self.articles = GlobalVariables.shared.appleArticales
            self.collectionView.reloadData()
        case 3:
            self.articles = GlobalVariables.shared.bitcoinsArticales
            self.collectionView.reloadData()

        default:
            break
            
        }
        let indexPath = IndexPath(item: 0, section: 0)
       collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
}
extension MainViewController : UICollectionViewDelegate,UICollectionViewDataSource{
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! ArticalCollectionViewCell
        cell.articalLabel.text = articles[indexPath.row]["title"] as? String
        let imageNAme = articles[indexPath.row]["urlToImage"] as? String
        cell.articalImage.sd_setImage(with: URL(string: imageNAme ?? ""), placeholderImage: UIImage(named: "no-image.png"))
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentArtical  = articles[indexPath.row]
        let destinationVC = storyboard?.instantiateViewController(identifier: "detailsVC") as! DetailsViewController
        destinationVC.artical = ArticalModel(author: (currentArtical["author"] as? String) ?? "No Author", publishDate: (currentArtical["publishedAt"] as? String)!, imageUrl: (currentArtical["urlToImage"] as? String)!, title: (currentArtical["title"] as? String) ?? "No Title", detials: (currentArtical["description"] as? String) ?? "No Author", url: (currentArtical["url"] as? String) ?? "No Title")
        navigationController?.pushViewController(destinationVC, animated: true)
        print(indexPath.row)
    }
    
    
}
// customize cell height and weight
extension MainViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:containerView.bounds.width - 30, height: containerView.bounds.height - 40)
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

