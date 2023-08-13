//
//  SystemExtensions.swift
//  MyNewsApp
//
//  Created by Thiago Emanoel on 13/08/23.
//

import UIKit

// Conseguem mudar o coportamento ate de libs internas do ios
// Mudar o comportamento do DateFormatter
extension DateFormatter {
    static let iso860Full: DateFormatter = {
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        return formatter;
    }()
}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode;
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mineType = response?.mimeType, mineType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                // Avisa a main thread que aconteceu algo
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(named: "no-image.png");
                }
                return;
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image;
            }
        }.resume();
    }
    
    func loadImage(from link: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let link = link, let url = URL(string: link) else {return}
        downloaded(from: url, contentMode: contentMode);
    }
}
