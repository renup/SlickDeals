//
//  DealDetailView.swift
//  SlickDeals
//
//  Created by renupunjabi on 7/6/23.
//

import SwiftUI

struct DealDetailView: View {
    let deal: Deal
    @Binding var path: NavigationPath
    
    @StateObject var viewModel = DealDetailViewModel()
    
    let rows = [
        GridItem(.fixed(150), spacing: 10, alignment: .center),
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                Text(deal.title)
                    .font(.body).bold()
                Text(deal.description)
                    .font(.caption2)
                    .foregroundColor(.gray)
                RemoteImage(url: deal.product.image, width: UIScreen.main.bounds.width-64, height: UIScreen.main.bounds.height/3)
                    .overlay(websiteOverlay, alignment: .bottom)
                    .cornerRadius(10)
                    .padding(15)
                    .shadow(radius: 10)
                pagination
                    .padding(.bottom, 10)
                HStack {
                    PriceView(price: Double(deal.price), discount: 1.3, fontSize: 20)
                    Spacer()
                    AvailabilityView(isAvailable: deal.product.availability.lowercased().hasPrefix("in"), fontSize: 20)
                }
                HStack {
                    if !deal.likes.isEmpty {
                        dealLikes
                    }
                    if !deal.dislikes.isEmpty {
                        dealDislikes
                    }
                }
                .padding(.bottom, 10)
                
                Text(deal.product.description)
                    .font(.caption)
                    .padding(.bottom, 10)
                
                if !deal.comments.isEmpty {
                    commentSection
                }
                // check whether to show or not
                if viewModel.shouldShowSuggestedDeals(deal: deal) {
                    suggestedDeals
                        .shadow(radius: 10)
                        .onAppear {
                            viewModel.getSuggestedDeals(deal: deal)
                        }
                }
            }
        }
        .padding()
        .padding(.horizontal, 16)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    path.removeLast(path.count)
                } label: {
                    Image(systemName: "house")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var dealDislikes: some View {
        HStack {
            Image(systemName: "hand.thumbsdown.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
            Text("\(deal.dislikes.count)")
        }
        .font(.callout).bold()
    }
    
    private var dealLikes: some View {
        HStack {
            Image(systemName: "hand.thumbsup.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.green)
            Text("\(deal.likes.count)")
            
        }
        .font(.callout).bold()
    }
    
    @ViewBuilder private var commentSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Comments")
                .font(.body).bold()
            ForEach(deal.comments) { comment in
                NavigationLink(value: comment.user) {
                    CommentView(comment: comment)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    @ViewBuilder private var suggestedDeals: some View {
        VStack {
            Text("Suggested Deals for you")
                .font(.body).bold()
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: rows) {
                    ForEach(viewModel.suggestedDeals) { deal in
                        NavigationLink(value: deal) {
                            DealCell(deal: deal)
                                .frame(width: 180)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder private var websiteOverlay: some View {
        Link(destination: deal.url) {
            HStack {
                Image(systemName: "safari")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 15)
                Text("Visit store page")
                    .font(.callout).bold()
                Spacer()
            }
            .font(.headline)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Color(.gray).opacity(0.25))
        }
    }
    
    private var pagination: some View {
        //Pagination
        HStack{
            HStack{
                ForEach(0..<6) { index in
                    if index == 2 {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 8, height: 8)
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 8, height: 8)
                            .foregroundColor(.gray)
                    }
                }
                
            }
            Spacer()
            //Favorite, Save button
            HStack{
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                
                Image(systemName: "bookmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
            }
        }
    }
    
}

struct DealDetailView_Previews: PreviewProvider {
    @State static var path = NavigationPath()
    
    static var previews: some View {
        DealDetailView(deal: Deal.mock, path: $path)
    }
}
