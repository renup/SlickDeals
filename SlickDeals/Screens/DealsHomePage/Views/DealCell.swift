//
//  DealCell.swift
//  SlickDeals
//
//  Created by renupunjabi on 7/3/23.
//

import SwiftUI

struct DealCell: View {
    let deal: Deal
    
    var body: some View {
        VStack (alignment: .leading){
            RemoteImage(url: deal.product.image)
                .aspectRatio(contentMode: .fit)
                .frame(width: 110, height: 130)
                .cornerRadius(10)
            
            Text(deal.title)
                .font(.system(.caption)).bold().lineLimit(2)
                .foregroundColor(.black)
                .padding(.bottom, 5)
            
            HStack(spacing: 8) {
                PriceView(price: Double(deal.price), discount: 1.3)
            }
            .font(.system(.caption)).bold()
            
            
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
    
    
}

struct DealCell_Previews: PreviewProvider {
    static var previews: some View {
        DealCell(deal: Deal.mock)
    }
}
