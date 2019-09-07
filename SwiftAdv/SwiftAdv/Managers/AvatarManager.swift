//
//  AvatarManager.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 31/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit

class AvatarManager {
    
    func saveAvatar(_ image: UIImage){
        let avatar = resizeImage(image: image, targetSize: CGSize(width: 40.0, height: 40.0))        
        let imageData = avatar.pngData()!
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let imageURL = docDir.appendingPathComponent(Defaults.selfie.rawValue)
        try! imageData.write(to: imageURL)
        print(imageURL.path)
    }
    
    func getAvatarPath() -> String {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return docDir.appendingPathComponent(Defaults.selfie.rawValue).path
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
