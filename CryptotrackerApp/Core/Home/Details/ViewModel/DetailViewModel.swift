//
//  DetailViewModel.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 12/04/2022.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
    
    @Published var overViewStatistics : [StatisticModel] = []
    @Published var additionalStatistics : [StatisticModel] = []
    @Published var coin : CoinModel
    @Published var coinDetails : [CoinModel] = []
    
    private let coinDetailService : CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin : CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map({ (coinDetailModel, coinModel) -> (overview : [StatisticModel], additional : [StatisticModel]) in
                
                let price = coinModel.currentPrice.asCurrencyWith2Decimals()
                let priceChange = coinModel.priceChangePercentage24H
                let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: priceChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
                let marketCapChange = coinModel.marketCapChangePercentage24H
                let marketCapStats = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
                
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticModel(title: "Rank", value: rank, percentageChange: nil)
                
                let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
                let volumeStat = StatisticModel(title: "volume", value: volume, percentageChange: nil)
                
                let overviewArray : [StatisticModel] = [
                    priceStat, marketCapStats, rankStat, volumeStat
                ]
                
                //additional
                
                let high = coinModel.high24H?.asCurrencyWith2Decimals() ?? "n/a"
                let highStat = StatisticModel(title: "24H High", value: high, percentageChange: nil)
                
                let low = coinModel.low24H?.asCurrencyWith2Decimals() ?? "n/a"
                let lowStat = StatisticModel(title: "24H Low", value: low, percentageChange: nil)
                
                let priceChange2 = coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
                let pricePercentChange2 = coinModel.priceChangePercentage24H
                let priceChangeStat = StatisticModel(title: "24H Price Change", value: priceChange2, percentageChange: pricePercentChange2)
                
                let marketCapChange2 = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
                let marketCapPercentChange2 = coinModel.marketCapChange24H
                let marketCapChangeStat = StatisticModel(title: "24H Market Cap Change", value: marketCapChange2, percentageChange: marketCapPercentChange2)
                
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
                let blockStat = StatisticModel(title: "Block Time", value: blockTimeString, percentageChange:   nil)
                
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing, percentageChange: nil)
                
                let additionalArray : [StatisticModel] = [
                    highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
                ]
                
                return (overviewArray, additionalArray)
            })
            .sink { [weak self] (returnedArrays) in
                self?.overViewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
    }
    
}
