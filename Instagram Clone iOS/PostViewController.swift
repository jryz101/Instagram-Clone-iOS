//  PostViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 05/10/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit

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
    
    
    
    
    
    
    
    //MARK: - post image action
    @IBAction func postImage(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
