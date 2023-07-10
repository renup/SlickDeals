//
//  PriceView.swift
//  SlickDeals
//
//  Created by renupunjabi on 7/7/23.
//

import SwiftUI

struct PriceView: View {
    let price: Double
    let discount: Double
    let fontSize: CGFloat
    
    init(price: Double, discount: Double, fontSize: CGFloat = 12) {
        self.price = price
        self.discount = discount
        self.fontSize = fontSize
    }
    
    var body: some View {
        HStack {
            // Original
            Text("$\( String(format: "%.0f", price * discount * 0.01))")
                .font(.system(size: fontSize))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .strikethrough(true, color: .red)
            //Discount price
            Text("$\( String(format: "%.0f", price * 0.01))")
                .font(.system(size: fontSize+3))
                .foregroundColor(.white)
                .padding(.horizontal, 5)
                .background(.red)
                .cornerRadius(5)
                .shadow(radius: 10)
        }
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(price: 2.5, discount: 1.5)
    }
}
