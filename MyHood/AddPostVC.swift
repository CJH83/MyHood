//
//  AddPostVC.swift
//  MyHood
//
//  Created by Chris Harrison on 13/12/2015.
//  Copyright © 2015 Chris Harrison. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        postImage.layer.cornerRadius = postImage.frame.size.width / 2
        postImage.clipsToBounds = true
        
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
    }

    @IBAction func makePostButtonPressed(sender: UIButton) {
        
        if let title = titleField.text, let description = descriptionField.text, let image = postImage.image {
            
            
            let imagePath = DataService.instance.saveImageAndCreatePath(image)
            
            
            var post = Post(imagePath: imagePath, title: title, description: description)
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func addPicButtonPressed(sender: AnyObject) {
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImage.image = image
    }
    
    

}
