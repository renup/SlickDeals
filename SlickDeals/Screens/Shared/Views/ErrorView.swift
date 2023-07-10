//
//  ErrorView.swift
//  SlickDeals
//
//  Created by renupunjabi on 7/3/23.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    
    var body: some View {
        Text(error.localizedDescription)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: APIError.invalidUrl)
    }
}
