//
//  CaptureViewController.swift
//  InstagramPlus
//
//  Created by Sean Nam on 12/14/17.
//  Copyright © 2017 seannam. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem!
    
    
    var resizedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.toggleUIElements()
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            vc.sourceType = .camera
        } else {
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }

    func toggleUIElements() {
        captionTextView.isHidden = !captionTextView.isHidden
        captureImageView.isHidden = !captureImageView.isHidden
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.captureImageView.image = editedImage
        self.toggleUIElements()
        
        let size = editedImage.size
        let smallerWidth = size.width * 0.7
        let smallerHeight = size.height * 0.7
        
        var smallerSize = CGSize()
        smallerSize.width = smallerWidth
        smallerSize.height = smallerHeight
        self.resizedImage = resize(image: editedImage, newSize: smallerSize)
        
        dismiss(animated: true, completion: nil)
    }

    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func onTapShareBarButton(_ sender: Any) {
        let caption = captionTextView.text
        
        Post.postUserImage(image: resizedImage, withCaption: caption) { (success: Bool, error: Error?) in
            if success {
                print("[DEBUG] tabBarController.selectedIndex = \(self.tabBarController?.selectedIndex)")
                print("successfully posted image with caption \(caption) as caption")
                self.toggleUIElements()
                self.captureImageView.image = nil
                self.captionTextView.text = ""
                self.shareBarButtonItem.title = ""
                
                self.navigationController?.navigationItem.hidesBackButton = true
                self.tabBarController?.selectedIndex = 0
                
            } else {
                print("Error occured while trying to post new image: \n\(error?.localizedDescription ?? "error message not found")")
            }
        }
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

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}
