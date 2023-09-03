//
//  MultipartImageControl.swift
//  TodoList_TripleDB
//
//  image upload를 위한 Class Module
//
//
//  Created by Okrie on 2023/08/29.
//

import Foundation
import UIKit

class ImageControl{

    func uploadImageToJSP(image: UIImage, imageName: String) {
        // JSP 서버 URL
        let jspURL = URL(string: "http://localhost:8080/ios/upload_image.jsp")!
        
        // Create the request
        var request = URLRequest(url: jspURL)
        request.httpMethod = "POST"
        
        // Prepare image data
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            // Create the body of the request
            var body = Data()
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            body.append(("Content-Disposition: form-data; name=\"images\"; filename=\'" + imageName + "'\"\r\n").data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            // Create URLSession task
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response: \(responseString ?? "")")
                }
            }
            task.resume()
        }
    }

}
