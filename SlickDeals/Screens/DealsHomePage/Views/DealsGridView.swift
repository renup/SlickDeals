//
//  DealsGridView.swift
//  SlickDeals
//
//  Created by Renu Punjabi on 7/1/23.
//

import SwiftUI

struct DealsGridView: View {
    @StateObject var viewModel = DealsGridViewModel()
    @State var path = NavigationPath()
    
    let column = [
        GridItem(.flexible(minimum: 165), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 165), spacing: 10, alignment: .center)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(showsIndicators: false) {
                searchField
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(16)
                LazyVGrid(columns: column) {
                    if viewModel.searchText.isEmpty {
                        ForEach(viewModel.deals) { deal in
                            dealNavigationLink(for: deal)
                        }
                    } else {
                        if viewModel.searchDeals.count == 0 {
                            Text("No results found for \(viewModel.searchText)")
                                .font(.title).bold()
                        } else {
                            ForEach(viewModel.searchDeals) { deal in
                                dealNavigationLink(for: deal)
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            
            .navigationTitle("Today's Deals")
            .navigationDestination(for: Deal.self) { deal in
                DealDetailView(deal: deal, path: $path)
            }
            .background(.white)
        }
    }
    
    
    
    private var searchField: some View {
        HStack(spacing: 5) {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $viewModel.searchText)
                
        }
    }
    
    private func dealNavigationLink(for deal: Deal) -> some View {
        let availability = deal.product.availability.lowercased().hasPrefix("in")
        
        return NavigationLink(value: deal) {
            DealCell(deal: deal)
                .overlay(AvailabilityView(isAvailable: availability), alignment: .topTrailing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DealsGridView()
    }
}
