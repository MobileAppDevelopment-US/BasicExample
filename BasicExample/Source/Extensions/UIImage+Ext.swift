//
//  UIImage+Extension.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

// Vertical Orientation
extension UIImage {
    
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
// let orientationChangedImage = image.fixOrientation()

// Уменьшение размера до пикселей
extension UIImage {
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    // let resizedImage = orientationChangedImage.resized(toWidth: 300)
}

//func imagePickerController(_ picker: UIImagePickerController,
//                           didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
//        let orientationChangedImage = image.fixOrientation(),
//        let resizedImage = orientationChangedImage.resized(toWidth: 300),
//        let data = resizedImage.jpegData(compressionQuality: 1) {
//
//        self.sendImageMessageRequest(data: data)
//    }
//
//    dismiss(animated: true, completion: nil)
//}
