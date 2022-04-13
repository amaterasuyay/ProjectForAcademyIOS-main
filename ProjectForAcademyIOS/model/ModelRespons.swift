//
//  ModelRespons.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 11.04.2022.
//

import UIKit

class ModelRespons {
    var news = [ModelNews]()
    init() {
        setup()
    }

    func setup() {
let news1 = ModelNews(imageNews: UIImage(data: try! Data(contentsOf: URL(string: "https://inlnk.ru/4yPLRm")!))!, imageNewsIcon: UIImage(data: try! Data(contentsOf: URL(string:"https://inlnk.ru/l0XvRQ")!))!, titleNewsLabel: "MDK", dataCreateNewsLabel: "11.04.2022", noteNewsText: "Пацаны, дождались! Наконец-то два самых лучших блюда на свете вместе, два в одном!")
let news2 = ModelNews(imageNews: UIImage(data: try! Data(contentsOf: URL(string: "https://inlnk.ru/ND9Zd0")!))!, imageNewsIcon: UIImage(data: try! Data(contentsOf: URL(string:"https://inlnk.ru/84jwkG")!))!, titleNewsLabel: "Joy-Dev", dataCreateNewsLabel: "9.04.2022", noteNewsText: "Компания мобильной и веб-разработки Joy Dev приглашает всех желающих на бесплатное обучение в Академию мобильной разработки! 🙌🏻   За 1 месяц мы научим тебя iOS или Android разработке. Ты научишься решать реальные задачи из бизнеса и получишь бесценный опыт! Научишься работать с основным стеком технологий, который обязательно пригодится тебе в работе!")
let news3 = ModelNews(imageNews: UIImage(data: try! Data(contentsOf: URL(string: "https://inlnk.ru/VoVmgz")!))!, imageNewsIcon: UIImage(data: try! Data(contentsOf: URL(string:"https://inlnk.ru/84jwgG")!))!, titleNewsLabel: "NR", dataCreateNewsLabel: "8.04.2022", noteNewsText: "Швеция намерена подать заявку на вступление в НАТО в июне.")
let news4 = ModelNews(imageNews: UIImage(data: try! Data(contentsOf: URL(string: "https://inlnk.ru/9PR3Lj")!))!, imageNewsIcon: UIImage(data: try! Data(contentsOf: URL(string:"https://inlnk.ru/VoVmLz")!))!, titleNewsLabel: "Apple", dataCreateNewsLabel: "8.04.2022", noteNewsText: "Обозреватель Bloomberg Марк Гурмэн (Mark Gurman) продолжает рассказывать, что представит Apple летом на конференции WWDC 2022. По его словам, компания приберегла для мероприятия два новых компьютера.    Как говорит Гурмэн, Apple готовится выпустить несколько новых компьютеров Mac в ближайшие несколько месяцев. Что может быть лучше для этого, чем WWDC? Именно на этом мероприятии два года назад Apple объявила о переходе с процессоров Intel на фирменные чипы.")
let news5 = ModelNews(imageNews: UIImage(data: try! Data(contentsOf: URL(string: "https://inlnk.ru/kXmVvz")!))!, imageNewsIcon: UIImage(data: try! Data(contentsOf: URL(string:"https://inlnk.ru/YAj397")!))!, titleNewsLabel: "DNS", dataCreateNewsLabel: "7.04.2022", noteNewsText: "Осушитель воздуха будет полезен в регионе с высокой влажностью, либо в ряде специфичных задач. В этом ролике выясним, когда и где именно они нужны, как правильно ими пользоваться, разберёмся как работает осушитель и попробуем найти недостатки.")
        
        news.append(news1)
        news.append(news2)
        news.append(news3)
        news.append(news4)
        news.append(news5)
    }
}



