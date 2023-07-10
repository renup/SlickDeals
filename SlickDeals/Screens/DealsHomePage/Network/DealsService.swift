//
//  DealsService.swift
//  SlickDeals
//
//  Created by Renu Punjabi on 7/2/23.
//

import Foundation

protocol DealsServiceProtocol {
    func fetchDeals() throws -> [Deal]
    func getDeal(id: String) -> Deal?
}

final class DealsService: DealsServiceProtocol {
    
    static let shared = DealsService()
    
    private var dealsDictionary: [String: Deal] = [:]
    
    func fetchDeals() throws -> [Deal] {
        
        guard let url = Bundle(for: type(of: self)).url(forResource: "getDealsWithAugments", withExtension: "json") else {
            throw APIError.invalidUrl
        }
        
        let data = try! Data(contentsOf: url)
        
        do {
            let result = try JSONDecoder().decode(DealsResponse.self, from: data)
            let deals = result.data.deals
            
            for ele in deals {
                dealsDictionary[ele.id] = ele
            }
            return deals
        } catch {
            throw APIError.decodingError
        }
    }
    
    func getDeal(id: String) -> Deal? {
        return dealsDictionary[id]
    }
    
    
}
