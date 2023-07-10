//
//  DealsGridViewModel.swift
//  SlickDeals
//
//  Created by Renu Punjabi on 7/1/23.
//

import Foundation
import Combine

enum SortOptions: String, CaseIterable {
    case latest, priceLow, priceHigh, rating
    
    var description: String {
        switch self {
        case .latest:
            return "Newest"
        case .priceLow:
            return "Price: Low"
        case .priceHigh:
            return "Price: High"
        case .rating:
            return "Ratings"
        }
    }
}

final class DealsGridViewModel: ObservableObject {
    
    @Published var deals = [Deal]()
    @Published var searchDeals = [Deal]()
    
    @Published var state: AppState = .initial
    @Published var searchText = ""
    @Published var sort: SortOptions = .latest

    let service: DealsServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(service: DealsServiceProtocol = DealsService.shared) {
        self.service = service
        getDeals()
        setUpSubscriptions()
    }
    
    private func setUpSubscriptions() {
        $searchText
            .sink {[weak self] newValue in
                guard let self = self else { return }
                if !newValue.isEmpty {
                    self.searchDeals = self.deals.filter { $0.title.hasPrefix(newValue) }
                } else {
                    searchDeals = []
                }
            }
            .store(in: &cancellables)
        
//        $sort
//            .sink {[weak self] option in
//                self?.getSortedDeals()
//            }
//            .store(in: &cancellables)
    }
    
    func getDeals() {
        state = .loading
        do {
            let result: [Deal] = try service.fetchDeals()
            
            deals = result
            //            deals = result.sorted(by: { first, second in
            //                return first.updatedAt > second.updatedAt
            //            })
            state = .loaded
        } catch {
            print("Error getting deals = \(error.localizedDescription)")
            state = .error
        }
    }
    
    
    
//    func getFilteredDeals() -> [Deal] {
//        if(searchText == ""){
//            return deals
//        }
//        var filtered: [Deal] = []
//        for deal in deals{
//            if(deal.description.lowercased().contains(searchText.lowercased()) ||
//               deal.title.lowercased().contains(searchText.lowercased()) || deal.product.description.lowercased().contains(searchText.lowercased())) {
//                filtered.append(deal)
//            }
//        }
//        return filtered
//    }
//
//    func compareDate(v1: Deal, v2: Deal, reversed: Bool) -> Bool{
//        if(Int(v1.updatedAt) ?? 0 > Int(v2.updatedAt) ?? 0){
//            return !reversed
//        }
//        if(Int(v1.updatedAt) ?? 0 == Int(v2.updatedAt) ?? 0){
//            return false
//        }
//        return reversed
//    }
//
//    func comparePrice(v1: Deal, v2: Deal, reversed: Bool) -> Bool{
//        if(v1.price > v2.price){
//            return !reversed
//        }
//        if(v1.price == v2.price){
//            return false
//        }
//        return reversed
//    }
//
//    func compareRating(v1: Deal, v2: Deal, reverse: Bool) -> Bool {
//        if (v1.likes.count - v1.dislikes.count) < (v2.likes.count - v2.dislikes.count) {
//            return true
//        }
//        return false
//    }
//
//    func getSortedDeals() {
//        var filteredDeals = deals
//        var sorted = false
//        var reversed = false
//        var comparingFunction: (Deal, Deal, Bool) -> Bool = compareDate
//        switch sort {
//        case .latest:
//            comparingFunction = compareDate
//            break;
//        case .priceLow:
//            comparingFunction = comparePrice
//            break;
//        case .priceHigh:
//            comparingFunction = comparePrice
//            reversed = true
//            break;
//        case .rating:
//            comparingFunction = compareRating
//            break;
//        default:
//            print(sort)
//            break;
//        }
//        while(!sorted){
//            sorted = true
//            for i in 0..<filteredDeals.count - 1 {
//                if(comparingFunction(filteredDeals[i], filteredDeals[i+1], reversed)){
//                    sorted = false
//                    let temp = filteredDeals[i+1]
//                    filteredDeals[i+1] = filteredDeals[i]
//                    filteredDeals[i] = temp
//                }
//            }
//        }
//        deals = filteredDeals
//    }
    
    
    
}
