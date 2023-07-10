//
//  DealDeatilsViewModel.swift
//  SlickDeals
//
//  Created by renupunjabi on 7/8/23.
//

import Foundation
import Combine

final class DealDetailViewModel: ObservableObject {
    @Published var suggestedDeals = [Deal]()

    let service: DealsServiceProtocol
    
    init(service: DealsServiceProtocol = DealsService.shared) {
        self.service = service
    }
    
    func shouldShowSuggestedDeals(deal: Deal) -> Bool {
        return !deal.likes.isEmpty
    }
    
    func getSuggestedDeals(deal: Deal) {
        var suggestedDealIds = Set<String>()
        for ele in deal.likes {
            guard let userLikes = ele.user.likes else {
                continue
            }
            
            for ele in userLikes {
                suggestedDealIds.insert(ele.id)
            }
        }
        
        var suggestedDeals = [Deal]()
        //Remove the parent deal id..
        suggestedDealIds.remove(deal.id)
        
        for ele in suggestedDealIds {
            guard let dealById = service.getDeal(id: ele) else { continue }
            suggestedDeals.append(dealById)
        }
        
        self.suggestedDeals = suggestedDeals
    } 
    
}
