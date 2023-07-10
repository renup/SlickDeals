//
//  AvailabilityView.swift
//  SlickDeals
//
//  Created by renupunjabi on 7/7/23.
//

import SwiftUI

struct AvailabilityView: View {
    let isAvailable: Bool
    let fontSize: CGFloat
    
    init(isAvailable: Bool, fontSize: CGFloat = 10) {
        self.isAvailable = isAvailable
        self.fontSize = fontSize
    }
    
    var body: some View {
        if isAvailable {
            HStack(spacing: 5) {
                Spacer()
                Text("In Stock")
                    .font(.system(size: fontSize)).bold()
                    .padding(5)
                    .background(Color.green)
                    .cornerRadius(5)
                    .foregroundColor(.white)
            }
        } else {
            HStack(spacing: 5) {
                Spacer()
                Text("Out of Stock")
                    .font(.system(size: fontSize)).bold()
                    .padding(5)
                    .background(Color.red)
                    .cornerRadius(5)
                    .foregroundColor(.white)
            }
        }
        
    }
}

struct AvailabilityView_Previews: PreviewProvider {
    static var previews: some View {
        AvailabilityView(isAvailable: true)
    }
}
