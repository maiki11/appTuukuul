//
//  UIImage.swift
//  appTuukuul
//
//  Created by Ernesto Jaramillo on 8/30/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    
    func circleImage() -> Void {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    //Cargar imagen desde url
    func loadImage(urlString: String, filter: String = "") -> Void {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage.init(data: data!) {
                    self.image = nil
                    self.image = downloadImage
                }
            }
        }).resume()
        
    }

}


