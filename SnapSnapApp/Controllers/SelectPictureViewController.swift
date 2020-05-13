//
//  SelectPictureViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/11/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseStorage

class SelectPictureViewController: UIViewController,  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  var imagePicker: UIImagePickerController?
  var imageAdded = false
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var messageTextField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imagePicker = UIImagePickerController()
    imagePicker?.delegate = self
    
  }
  
  
  @IBAction func selectPhotoButtonTapped(_ sender: UIBarButtonItem) {
    if let imagePicker = imagePicker{
      imagePicker.sourceType = .photoLibrary
      present(imagePicker, animated: true, completion: nil)
    }
    
  }
  
  
  @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
    if let imagePicker = imagePicker{
      imagePicker.sourceType = .camera
      present(imagePicker, animated: true, completion: nil)
    }
  }
  
  
  @IBAction func nextButtonTapped(_ sender: UIButton) {
    
    // DELETE THIS FOR PRODUCTION!!!
    messageTextField.text = "test"
    imageAdded = true
    
    
    if let message = messageTextField.text{
      if imageAdded && (message != ""){
        // Upload an image
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesFolder = storageRef.child("images")
        
        if let image = imageView.image{
          if let imageData = image.jpegData(compressionQuality: 0.75){
            //NSUUID().uuidString - universal name of a file such as image.jpg
            imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
              if let error = error{
                
                self.presentAlert(alert: error.localizedDescription)
                
              }else{
                // segue to next viewController
                print("Image loaded")
              }
            }
            
          }
        }
        // Segue to next view
      }else{
        // Error:
        presentAlert(alert: "You must provide an image and a message for your snap")
        
      }
    }
    
    
  }
  
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage{
      
      // assigned to an outlet
      imageView.image = image
      imageAdded = true
      
      
    }
    
    
    dismiss(animated: true, completion: nil)
  }
  
  
  
}


extension SelectPictureViewController{
  func presentAlert(alert:String){
    
    let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
      alertVC.dismiss(animated: true, completion: nil)
    }
    alertVC.addAction(okAction)
    present(alertVC, animated: true, completion: nil)
  }
}
