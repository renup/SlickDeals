//
//  RemoteImage.swift
//  SlickDeals
//
//  Created by renupunjabi on 7/4/23.
//

import SwiftUI

struct RemoteImage: View {
    @ObservedObject var imageLoader: ImageLoader
    
    let width: CGFloat
    let height: CGFloat
    init(url: String, width: CGFloat = 110, height: CGFloat = 130) {
        imageLoader = ImageLoader(url: url)
        self.width = width
        self.height = height
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .background(.white)
                .cornerRadius(10)
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .cornerRadius(10)
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var url: String
    private var task: URLSessionDataTask?
    
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: url) else { return }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
                ImageCache.shared.set(image!, forKey: self.url)
            }
        }
        task?.resume()
    }
}

