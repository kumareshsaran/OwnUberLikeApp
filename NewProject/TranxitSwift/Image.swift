//
//  Image.swift
//  User
//
//  Created by CSS on 09/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    func resizeImage(newWidth: CGFloat) -> UIImage?{
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: newWidth, height: newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //MARK:- Image Comparision 
    
    func isEqual(to image : UIImage?) -> Bool {
        
        guard  image != nil, let imageData1 = UIImagePNGRepresentation(image!)  else {
            return false
        }
        
        guard let imageData2 = UIImagePNGRepresentation(self) else {
            return false
        }
        
        return imageData1 == imageData2
        
    }
    
    
    func imageWithInsets(insetDimen: CGFloat) -> UIImage {
        return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
    }
    
    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
        UIGraphicsEndImageContext()
        return imageWithInsets!
    }

    func flip() -> UIImage {
        
        let img = self.imageFlippedForRightToLeftLayoutDirection()
        return img
        
    }
    
}

extension UIImageView {
    func setImage(with urlString : String?,placeHolder placeHolderImage : UIImage?) {
        self.image = placeHolderImage
        guard urlString != nil, let imageUrl = URL(string: urlString!) else {
            return
        }
        if let image = Cache.shared.object(forKey: urlString! as AnyObject) {
            self.image = image
        } else {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                guard data != nil, let imagePic = UIImage(data: data!), let responseUrl = response?.url?.absoluteString else {
                    return
                }
                DispatchQueue.main.async {
                    self.image = imagePic
                }
                Cache.shared.setObject(imagePic, forKey: responseUrl as AnyObject)
                }.resume()
        }
    }
    
    func tintImageColor(color : UIColor = .imageTintColor , setimage: UIImage) {
        self.image = setimage
        self.image = self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.tintColor = color
    }

}
