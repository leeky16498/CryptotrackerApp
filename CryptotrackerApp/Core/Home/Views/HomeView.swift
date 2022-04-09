//
//  HomeView.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 06/04/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortfolio : Bool = false
    @State private var showPortfolioView : Bool = false
    
    var body: some View {
        ZStack { // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm) // 부모뷰의 environmentObject를 다음과 같이 전달 가능하다.
                })
            
            //content layer
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                    
                if showPortfolio {
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer()

            }//vst
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
                .environmentObject(dev.homeVM)
        }
    }
}

extension HomeView {
    
    private var homeHeader : some View { // 상수 선언 후 조작
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                 CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }//hst
        .padding(.horizontal)
    }
    
    private var allCoinList : some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinList : some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles : some View {
        HStack {
            Text("coin")
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
            }
            Text("price")
                .frame(width : UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
