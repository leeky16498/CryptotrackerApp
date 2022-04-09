//
//  PortfolioView.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 09/04/2022.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectedCoin : CoinModel?
    @State private var quantityText : String = ""
    @State private var showCheckMark : Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInput
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    xmarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark")
                            .opacity(showCheckMark ? 1.0 : 0.0)
                        Button(action: {
                            
                        }, label: {
                            Text("Save".uppercased())
                        })
                        .opacity(
                            (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
                        )
                    }
                    .font(.headline)
                }
            }
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    
    private var coinLogoList : some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width : 75)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green
                                        : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private var portfolioInput : some View {
        VStack(spacing : 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            
            Divider()
            
            HStack {
                Text("Amount in your portfolio")
                    .lineLimit(1)
                Spacer()
                TextField("Ex : 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack {
                Text("Current value")
                    
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        } // vst
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
}
