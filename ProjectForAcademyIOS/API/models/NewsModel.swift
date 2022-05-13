//
//  Respons.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 11.04.2022.
//

import UIKit

// MARK: - News
struct News: Codable {
    let totalArticles: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let title: String
    let articleDescription: String?
    let content: String?
    let url: String?
    let image: String?
    let publishedAt: String?
    let source: Source?
    
    enum CodingKeys: String, CodingKey {
        case title
        case articleDescription = "description"
        case content, url, image, publishedAt, source
    }
}

// MARK: - Source
struct Source: Codable {
    let name: String?
    let url: String?
}

