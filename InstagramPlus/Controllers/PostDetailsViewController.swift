//
//  PostDetailsViewController.swift
//  InstagramPlus
//
//  Created by Sean Nam on 12/14/17.
//  Copyright © 2017 seannam. All rights reserved.
//

import UIKit
import Parse

class PostDetailsViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("post details \(post)")
        
        userLabel.text = post?["author"] as? String
        userCommentLabel.text = userLabel.text
        captionLabel.text = post?["caption"] as? String
        
        let likeCount = post?["likesCount"] ?? 0
        likeCountLabel.text = "\(likeCount) likes"
        
        let date = post?["timestamp"] as? Date
        if date != nil {
            timestampLabel.text = date?.toString(dateFormat: "MM-dd-yyy hh:mm")
        } else {
            timestampLabel.text = "No date info"
        }
        
        if let postImage = post?["media"] as? PFFile {
            postImage.getDataInBackground(block: { (imageData: Data?, error: Error?) in
                if let imageData = imageData {
                    self.postImageView.image = UIImage.init(data: imageData)
                }
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapLikeButton(_ sender: Any) {
    }
    
    @IBAction func onTapCommentButton(_ sender: Any) {
    }
    @IBAction func onTapShareButton(_ sender: Any) {
    }
    
    @IBAction func onTapBookmarkButton(_ sender: Any) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
