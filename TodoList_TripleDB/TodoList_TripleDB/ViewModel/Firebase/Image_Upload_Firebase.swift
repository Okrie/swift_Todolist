//
//  Image_Upload_Firebase.swift
//  TodoList_TripleDB
//
//  Firebase 사용을 위한 ViewModel
//  Image Upload / Load를 위한 뷰모델 따로 분리
//  이는 다른 뷰에서 재사용하기 위함
//
//  Created by Okrie on 2023/08/29.
//

import Foundation
import UIKit
import FirebaseStorage

class ImageUpload_Firebase{
    
    // Upload & return Image Url String
    func uploadFile(image: UIImage, imageName: String) -> (String){
        var returnUrl: String = ""
        // Image Uploading on Firebase Storage
        if let imageData = image.jpegData(compressionQuality: 0.6){
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let boundary = UUID().uuidString
            let imageRef = storageRef.child("images/" + boundary + "_" + dateNow() + ".png")
            
            // Firebase Upload
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard let _ = metadata else{
                    // Failed to Upload
                    print("Error Upload image : \(error!.localizedDescription)")
                    return
                }
                
                // Success Upload & return image url
                imageRef.downloadURL{ (url, error) in
                    if let downloadURL = url {
                        returnUrl = downloadURL.absoluteString
                    } else {
                        print("Error download URL : \(error!.localizedDescription)")
                    }
                }
            }
        } else{
            return returnUrl
        }
        
        return returnUrl
    }
}
