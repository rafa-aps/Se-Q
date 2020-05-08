//
//  UIImageView+Extension.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

extension UIImageView {
    
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
    
    func load(url: URL) {
        self.image = UIImage(named: "placeholder")
        let activityIndicator = self.activityIndicator
        activityIndicator.startAnimating()
        let session = URLSession(configuration: .default)
        DispatchQueue.global().async { [weak self] in
            
            let downloadImageTask = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let imageData = data {
                        DispatchQueue.main.async {[weak self] in
                            var image = UIImage(data: imageData)
                            self?.image = nil
                            self?.image = image
                            image = nil
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
                session.finishTasksAndInvalidate()
            }
            
            downloadImageTask.resume()
        }
    }
}
