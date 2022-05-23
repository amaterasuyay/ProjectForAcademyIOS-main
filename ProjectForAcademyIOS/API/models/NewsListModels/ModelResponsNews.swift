//
//  ModelRespons.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 11.04.2022.
//

import UIKit

class CellViewModel {
    var imageData: Data? = nil
    let imageNews: URL?
    let titleNews: String
    let discription: String
    let dataContent: String
    
    init(imageNews: URL, titleNews: String, discription: String, dataContent: String){
        self.imageNews = imageNews
        self.titleNews = titleNews
        self.discription = discription
        self.dataContent = dataContent
        
    }
}


