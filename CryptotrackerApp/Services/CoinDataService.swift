//
//  CoinDataService.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 06/04/2022.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins : [CoinModel] = []
    
//    var cancellable = Set<AnyCancellable>()
    var coinSubsciption : AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        
        let coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // 백그라운드에서 작업하고
            .tryMap { (output) -> Data in
                
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main) // 메인스레드로 불러온다.
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubsciption?.cancel()
            }
//            .store(in: &cancellable)
        // 다음과 같이 섭스크립터를 생성해서 캔슬해주는 방법도 있음.
    }
    
}
