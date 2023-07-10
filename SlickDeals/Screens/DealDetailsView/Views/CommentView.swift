//
//  CommentView.swift
//  SlickDeals
//
//  Created by renupunjabi on 7/7/23.
//

import SwiftUI

struct CommentView: View {
    let comment: Comment
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Image("profile\((1...5).randomElement() ?? 1)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                Text(comment.user.name)
                    .font(.caption2).bold()
            }
            Text(comment.text)
                .font(.caption)
        }
        .multilineTextAlignment(.leading)

    }
}

struct CommentView_Previews: PreviewProvider {
    
    static var previews: some View {
        CommentView(comment: Comment.mock)
    }
}
