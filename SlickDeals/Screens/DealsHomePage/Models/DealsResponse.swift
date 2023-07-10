//
//  DealsResponse.swift
//  SlickDeals
//
//  Created by Renu Punjabi on 7/1/23.
//

import Foundation

struct DealsResponse: Codable {
    let data: DealsData
}

struct DealsData: Codable, Hashable {
    let deals: [Deal]
}

struct Deal: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let url: URL
    let price: Int
    let description: String
    let product: Product
    let createdAt: String
    let updatedAt: String
    let likes: [Like]
    let dislikes: [Like]
    let comments: [Comment]

    static let mock = Deal(id: "1", title: "mock title", url: URL(string: "https://www.officedepot.com/a/products/9025577/My-Arcade-All-Star-Stadium-Pico/")! , price: 10, description: "deal description", product: Product.mock, createdAt: "today", updatedAt: "today", likes: [Like.mock], dislikes: [Like.mock], comments: [Comment.mock])
}

struct Comment: Codable, Hashable, Identifiable {
    let id: String
    let createdAt: String
    let text: String
    let user: User

    static let mock = Comment(id: "1", createdAt: "123456", text: "Sample comment", user: User.mock)
}

struct Product: Codable, Hashable {
    let availability: String
    let image: String
    let description: String
    let sku: String
    let updatedAt: String

    static let mock = Product(availability: "now", image: "https://media.officedepot.com/images/t_extralarge%2Cf_auto/products/9025577/9025577_o01.jpg", description: "product description", sku: "1j", updatedAt: "today")
}

struct Like: Codable, Hashable {
    let id: String
    let user: User

    static let mock = Like(id: "1", user: User.mock)
}

struct User: Codable, Hashable {
    let id: String?
    let name: String
    let likes: [LikedDeal]?

    static let mock = User(id: "1", name: "Renu", likes: [LikedDeal.mock])
}

struct LikedDeal: Codable, Hashable {
    let id: String
    let deal: ShortDealInfo

    static let mock = LikedDeal(id: "1", deal: ShortDealInfo.mock)

}

struct ShortDealInfo: Codable, Hashable {
    let id: String
    let title: String
//    let url: URL
//    let price: Int
//    let createdAt: String
//    let updatedAt: String
    
    static let mock = ShortDealInfo(id: "1", title: "deal title")

//    static let mock = ShortDealInfo(id: "1", title: "deal title", url: URL(string: "https://media.officedepot.com/images/t_extralarge%2Cf_auto/products/9025577/9025577_o01.jpg")!, price: 10, createdAt: "today", updatedAt: "today")
}

