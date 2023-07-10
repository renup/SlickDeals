//
//  DealsGridViewModel.swift
//  SlickDeals
//
//  Created by Renu Punjabi on 7/1/23.
//

import Foundation
import Combine

final class DealsGridViewModel: ObservableObject {
    
    @Published var deals = [Deal]()
    @Published var searchDeals = [Deal]()
    
    @Published var state: AppState = .initial
    @Published var searchText = ""

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
    }
    
    func getDeals() {
        state = .loading
        do {
            let result: [Deal] = try service.fetchDeals()
            deals = result
            state = .loaded
        } catch {
            print("Error getting deals = \(error.localizedDescription)")
            state = .error
        }
    }
    
}
