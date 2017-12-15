//
//  HomeViewController.swift
//  InstagramPlus
//
//  Created by Sean Nam on 12/14/17.
//  Copyright © 2017 seannam. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getPosts()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 430
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPosts()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts() {
        var query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        //query.whereKey("author", equalTo: PFUser.current())
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts
                
//                for post in posts {
//                    print(post["author"])
//                    print(post["caption"])
//                }
                
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = self.posts[indexPath.row]
        cell.post = post
        return cell
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
