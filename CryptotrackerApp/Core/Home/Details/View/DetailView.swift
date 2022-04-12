//
//  DetailView.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 12/04/2022.
//

import SwiftUI

struct DetailView: View {
    
    let coin : CoinModel
    @StateObject var vm : DetailViewModel
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat =  30
    
    init(coin : CoinModel) {
        self.coin = coin // 바인딩된 변수를 파라미터로 받아올 때 언더바를 사용한다.
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        //stateObject를 초기화해줄때는 다음과 같이 언더바를 통한 후에 진행한다.
        print(coin.name)
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Text("")
                    .frame(height : 150)
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth : .infinity, alignment: .leading)
                
                Divider()
                
                LazyVGrid(columns: columns,
                          alignment: .leading,
                          spacing: nil,
                          pinnedViews: []) {
                    ForEach(vm.overViewStatistics) { stat in
                        StatisticView(stats: stat)
                            .padding(.vertical)
                    }
                }
                
                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth : .infinity, alignment: .leading)
                
                Divider()
                
                LazyVGrid(columns: columns,
                          alignment: .leading,
                          spacing: nil,
                          pinnedViews: []) {
                    ForEach(vm.additionalStatistics) { stat in
                        StatisticView(stats: stat)
                            .padding(.vertical)
                    }
                }
            }//vst
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin : dev.coin)
        }
    }
}

struct DetailLoadingView : View {
    
    @Binding var coin : CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
    
}
