//  PostViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 05/10/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK: - outlets object
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var comment: UITextField!
    
    
    
    //MARK: - upload image action
    @IBAction func uploadImage(_ sender: Any) {
        
        ////A view controller that manages the system interfaces for taking pictures, recording movies, and choosing items from the user's media library.
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        imagePicker.allowsEditing = false
        
        ////Presents a view controller modally.
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: - did finish picking media with info function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        ////cast the UI Image Picker Controller Info Key orginal Image to UI image
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            ///set image to post equals to image
            imageToPost.image = image
            
        }
        ////dismiss did Finish Picking Media With Info function
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - display alert function
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    //MARK: - post image action
    @IBAction func postImage(_ sender: Any) {
        
        if let image = imageToPost.image {
        
        ////new PFObject class "Post"
        let post = PFObject(className: "Post")
        
        ////sender userid and message which is comment and objectId
        post["message"] = comment.text
        post["userid"] = PFUser.current()?.objectId
            
            ////image data | returns the data for the specified image in PNG format
            if let imageData = image.pngData() {
                
                ////spinner activity indicator
                let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.style = UIActivityIndicatorView.Style.gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                ////image file | `PFFileObject` representes a file of binary data stored on the Parse servers
                let imageFile = PFFileObject(name: "image.png", data: imageData)
                
                ////add image file to post
                post["imageFile"] = imageFile
                
                ////save post in background
                post.saveInBackground { (success, error) in
                    
                    ////Stops the animation of the progress indicator
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if success {
                        
                        //// image posted successfully message
                        self.displayAlert(title: "Image Posted", message: "Your image has been posted successfully")
                        
                        ////reset comment and image to post to default
                        self.comment.text = ""
                        self.imageToPost.image = nil
                        
                    } else {
                        
                        //// image could not be posted message
                        self.displayAlert(title: "Image could not be posted", message: "Please try again")
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
