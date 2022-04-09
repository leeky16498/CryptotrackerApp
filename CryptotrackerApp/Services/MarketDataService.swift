//
//  MarketDataService.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 09/04/2022.
//

import Foundation
import Combine
 
class MarketDataService {
    
    @Published var marketData : MarketDataModel?
    
//    var cancellable = Set<AnyCancellable>()
    var marketDataSubsciption : AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        
        let coinSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubsciption?.cancel()
            })
//            .store(in: &cancellable)
        // 다음과 같이 섭스크립터를 생성해서 캔슬해주는 방법도 있음.
    }
    
}
