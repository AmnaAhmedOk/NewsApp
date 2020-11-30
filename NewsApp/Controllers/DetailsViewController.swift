//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Amna on 11/20/20.
//  Copyright © 2020 Amna. All rights reserved.
//

import UIKit
import SDWebImage
class DetailsViewController: UIViewController {

    var artical  : ArticalModel?
    
    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var articalDetails: UILabel!
    @IBOutlet weak var articalTitle: UILabel!
    @IBOutlet weak var articalImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let date = artical?.publishDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ'"
     
        let dateObj = dateFormatter.date(from: date ??  "")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy"
        publishDate.text = "Published at :\(dateFormatter.string(from: dateObj!))"
        authorLabel.text = "by:\(artical?.author ?? "")"
        articalImage.sd_setImage(with: URL(string: artical?.imageUrl ?? ""), placeholderImage: UIImage(named: "no-image.png"))
        articalDetails.text = artical?.detials
        articalTitle.text = artical?.title
        let tap = UITapGestureRecognizer(target: self, action: #selector(openLink))
        urlLabel.addGestureRecognizer(tap)

    }
    
 @objc  func openLink()  {
    if let url = URL(string: artical!.url), UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
