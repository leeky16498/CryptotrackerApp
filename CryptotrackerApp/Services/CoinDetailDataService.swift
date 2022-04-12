//
//  CoinDetailDataService.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 12/04/2022.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    let coin : CoinModel
    @Published var coinDetails : CoinDetailModel?
    
//    var cancellable = Set<AnyCancellable>()
    var coinDetailsSubsciption : AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
        
        let coinSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailsSubsciption?.cancel()
            })
//            .store(in: &cancellable)
        // 다음과 같이 섭스크립터를 생성해서 캔슬해주는 방법도 있음.
    }
}
