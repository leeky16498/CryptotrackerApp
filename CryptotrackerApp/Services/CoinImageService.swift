//
//  CoinImageService.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 07/04/2022.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
    
    @Published var image : UIImage? = nil

    private let coin : CoinModel
    private var imageSubscription : AnyCancellable?
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_Images"
    private let imageName : String
    
    init(coin : CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
            print("Get image from fileManager")
        } else {
            downloadCoinImage()
            print("Download Images!")
        }
    }
    
    private func downloadCoinImage() {
        print("downloading Images!")
        guard let url = URL(string: coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadImage = returnedImage else {return}
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadImage, folderName: self.folderName , imageName: self.imageName)
            })
    }
    
}
