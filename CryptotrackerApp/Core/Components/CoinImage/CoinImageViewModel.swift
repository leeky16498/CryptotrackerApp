//
//  CoinImageViewModel.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 07/04/2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    
    @Published var image : UIImage?
    @Published var isLoading : Bool = false
    
    private let coin : CoinModel
    private let dataService : CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin : CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.isLoading = true
        addSubscriber()
    }
    
    private func addSubscriber() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
    
}
