//
//  StatisticView.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 09/04/2022.
//

import SwiftUI

struct StatisticView: View {
    
    let stats : StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stats.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stats.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(.degrees((stats.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stats.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stats.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stats.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    
    static var previews: some View {
        StatisticView(stats: dev.stats3)
    }
}
