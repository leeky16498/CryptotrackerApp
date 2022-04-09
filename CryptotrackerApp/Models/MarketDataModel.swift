//
//  MarketDataModel.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 09/04/2022.
//

import Foundation

//JSON Data example
/*
 URL: https://api.coingecko.com/api/v3/global
 
 {
   "data": {
     "active_cryptocurrencies": 13617,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 788,
     "total_market_cap": {
       "btc": 48603215.485200286,
       "eth": 638974844.8680506,
       "ltc": 18429373407.14464,
       "bch": 6333546543.477724,
       "bnb": 4899594715.692492,
       "eos": 860545562883.9988,
       "xrp": 2712764004626.856,
       "xlm": 10098868552860.664,
       "link": 135138030633.07738,
       "dot": 105573428442.6717,
       "yfi": 101361084.13679722,
       "usd": 2066565252804.7715,
       "aed": 7590494173551.905,
       "ars": 231828889581144.8,
       "aud": 2770195589775.4966,
       "bdt": 178377793087229.2,
       "bhd": 779355487529.2522,
       "bmd": 2066565252804.7715,
       "brl": 9712030062081.297,
       "cad": 2597734519733.1816,
       "chf": 1933015539907.515,
       "clp": 1684250681035886.2,
       "cny": 13153894490627.65,
       "czk": 46428488252138.34,
       "dkk": 14131793168254.865,
       "eur": 1900026958776.9917,
       "gbp": 1585349001167.1543,
       "hkd": 16200352656528.602,
       "huf": 718058062283183.1,
       "idr": 29697885950218840,
       "ils": 6658948554545.101,
       "inr": 156888467579806.2,
       "jpy": 256925705050601.34,
       "krw": 2540129013311245.5,
       "kwd": 630248671408.8821,
       "lkr": 652064687817729.1,
       "mmk": 3832706132124565.5,
       "mxn": 41407943628495.664,
       "myr": 8724005214715.334,
       "ngn": 858967847328300.9,
       "nok": 17996778566051.973,
       "nzd": 3017654379407.3516,
       "php": 106634760845030.22,
       "pkr": 384949442466208.4,
       "pln": 8805064170191.346,
       "rub": 167081978413877.44,
       "sar": 7750795573646.72,
       "sek": 19527471049412.934,
       "sgd": 2817761722199.3047,
       "thb": 69408625666674.016,
       "try": 30479977570142.844,
       "twd": 59737581793251.82,
       "uah": 60782455784157.21,
       "vef": 206925178763.34152,
       "vnd": 47246576423647480,
       "zar": 30291093506036.477,
       "xdr": 1488856936383.195,
       "xag": 83398183348.27399,
       "xau": 1061098594.7051352,
       "bits": 48603215485200.29,
       "sats": 4860321548520029
     },
     "total_volume": {
       "btc": 1925966.4288335138,
       "eth": 25320219.820840865,
       "ltc": 730288194.5620604,
       "bch": 250975123.6912915,
       "bnb": 194152893.85919806,
       "eos": 34100251352.729843,
       "xrp": 107496846661.31215,
       "xlm": 400180967613.8545,
       "link": 5355022453.961607,
       "dot": 4183486152.667354,
       "yfi": 4016566.4614738235,
       "usd": 81890370012.81917,
       "aed": 300783329057.084,
       "ars": 9186525091184.438,
       "aud": 109772648865.8938,
       "bdt": 7068454992242.753,
       "bhd": 30882987681.454433,
       "bmd": 81890370012.81917,
       "brl": 384851982912.2446,
       "cad": 102938651817.21405,
       "chf": 76598286741.11069,
       "clp": 66740651560447.516,
       "cny": 521240394168.5952,
       "czk": 1839789997892.9995,
       "dkk": 559990917258.6611,
       "eur": 75291070764.59604,
       "gbp": 62821542232.37396,
       "hkd": 641960311478.543,
       "huf": 28453996471319.188,
       "idr": 1176817845824717.8,
       "ils": 263869606966.40555,
       "inr": 6216912165448.196,
       "jpy": 10181019459144.951,
       "krw": 100655957753106.6,
       "kwd": 24974433704.289497,
       "lkr": 25838922088337.15,
       "mmk": 151876028537741.1,
       "mxn": 1640844304628.3074,
       "myr": 345700197009.1157,
       "ngn": 34037732295828.188,
       "nok": 713146054213.6559,
       "nzd": 119578529332.70882,
       "php": 4225542846990.3496,
       "pkr": 15254128674137.871,
       "pln": 348912264882.4985,
       "rub": 6620843458108.247,
       "sar": 307135483168.6084,
       "sek": 773801759939.9303,
       "sgd": 111657519512.47888,
       "thb": 2750408210053.3364,
       "try": 1207809256356.0706,
       "twd": 2367180358849.565,
       "uah": 2408584866941.3774,
       "vef": 8199682749.383574,
       "vnd": 1872207819191924.8,
       "zar": 1200324476536.8984,
       "xdr": 58997917075.73546,
       "xag": 3304762858.815121,
       "xau": 42047429.38678202,
       "bits": 1925966428833.5137,
       "sats": 192596642883351.38
     },
     "market_cap_percentage": {
       "btc": 39.10691465626942,
       "eth": 18.827678185231385,
       "usdt": 3.9949839166637577,
       "bnb": 3.431245258695382,
       "usdc": 2.4614587188126995,
       "xrp": 1.7743266766551573,
       "sol": 1.744787562378827,
       "luna": 1.6100517549282962,
       "ada": 1.5993004683141372,
       "avax": 1.0783800529994199
     },
     "market_cap_change_percentage_24h_usd": -1.329977413678739,
     "updated_at": 1649533399
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
        
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap : String {
//        if let item = totalMarketCap.first(where: { (key, value) in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        } 이 코드와 아래의 코드가 같은 의미이다.
        
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var volume : String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance : String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
}
