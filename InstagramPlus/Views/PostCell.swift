//
//  PostCell.swift
//  InstagramPlus
//
//  Created by Sean Nam on 12/14/17.
//  Copyright © 2017 seannam. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject? {
        didSet {
            userLabel.text = post?["author"] as? String
            userCommentLabel.text = userLabel.text
            captionLabel.text = post?["caption"] as? String
            let likeCount = post?["likesCount"]
            likeCountLabel.text = "\(likeCount!) likes"
            
            if let postImage = post?["media"] as? PFFile {
                postImage.getDataInBackground(block: { (imageData: Data?, error: Error?) in
                    if let imageData = imageData {
                        self.postImageView.image = UIImage.init(data: imageData)
                    }
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }
    
    @IBAction func onTapLikeButton(_ sender: Any) {
        print("Like button tapped")
    }
    
    @IBAction func onTapCommentButton(_ sender: Any) {
        print("Comment button tapped")
    }
    
    @IBAction func onTapShareButton(_ sender: Any) {
        print("Share button tapped")
    }
    
    @IBAction func onTapBookmarkButton(_ sender: Any) {
        print("Bookmark button tapped")
    }
}
