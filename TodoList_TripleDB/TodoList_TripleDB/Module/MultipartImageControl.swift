//
//  MultipartImageControl.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/29.
//

import Foundation

class ImageControl{
    let boundary = "Boundary-\(UUID().uuidString)"
//    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//    var body = Data()
//    body.append("--\(boundary)\r\n".data(using: .utf8)!)
//    body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
//    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//    body.append(image)
//    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//    request.httpBody = body
}
