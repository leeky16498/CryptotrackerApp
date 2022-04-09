//
//  HomeStatsView.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 09/04/2022.
//

import SwiftUI

struct HomeStatsView: View {

    @Binding var showPortfolio : Bool
    @EnvironmentObject var vm : HomeViewModel
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stats: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width : UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
