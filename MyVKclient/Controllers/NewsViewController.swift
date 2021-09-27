//
//  NewsViewController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 06.07.2021.
//

import UIKit
import RealmSwift
<<<<<<< HEAD
<<<<<<< HEAD
=======
import Kingfisher
>>>>>>> lesson2
=======
import Kingfisher
>>>>>>> lesson3

final class NewsViewController: UIViewController {    
    
    @IBOutlet var newsTableView: UITableView!
    
    private let newsTableCellIdentifire = "newsTableCellIdentifire"
    private let textNewsCell = "textNewsCell"
    private let imageNewsCell = "imageNewsCell"
    private let infoNewsCell = "infoNewsCell"
<<<<<<< HEAD
<<<<<<< HEAD
=======
    private let titleNewsCell = "titleNewsCell"
>>>>>>> lesson2
=======
    private let titleNewsCell = "titleNewsCell"
>>>>>>> lesson3
    private let networkNews = NetworkNews()
    private var newsModel = NewsModel()
    private var newsChangedToken : NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "TextNewsCell", bundle: nil),
                               forCellReuseIdentifier: textNewsCell)
        newsTableView.register(UINib(nibName: "ImageNewsCell", bundle: nil),
                               forCellReuseIdentifier: imageNewsCell)
        newsTableView.register(UINib(nibName: "InfoNewsCell", bundle: nil),
                               forCellReuseIdentifier: infoNewsCell)
<<<<<<< HEAD
<<<<<<< HEAD
=======
        newsTableView.register(UINib(nibName: "TitleNewsCell", bundle: nil),
                               forCellReuseIdentifier: titleNewsCell)
>>>>>>> lesson2
=======
        newsTableView.register(UINib(nibName: "TitleNewsCell", bundle: nil),
                               forCellReuseIdentifier: titleNewsCell)
>>>>>>> lesson3
        self.newsTableView.dataSource = self
        self.newsTableView.delegate = self
        newsTableView.reloadData()

        do {
            let realm = try Realm()
            let news = realm.objects(RealmNews.self)
            newsChangedToken = news.observe { chenge  in
                switch chenge{
                case .initial(let initial):
<<<<<<< HEAD
<<<<<<< HEAD
                print(initial)
=======
                    print(initial)
>>>>>>> lesson2
=======
                    print(initial)
>>>>>>> lesson3
                case .update(let resoults, let deletions, let insertions, let modifications):
                    print(resoults,deletions, insertions, modifications)
                case .error( let error):
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newsModel.newsArray = [News]()
        newsModel.setupNews()
        if newsModel.newsArray.isEmpty { navigationItem.title = "Выберите группы"}
        else {navigationItem.title = "Новости"}
        newsTableView.reloadData()

    }

<<<<<<< HEAD
    override func viewDidAppear(_ animated: Bool) {
<<<<<<< HEAD
        newsTableView.reloadData()
=======

        newsTableView.reloadData()

>>>>>>> lesson2
    }
=======
//    override func viewDidAppear(_ animated: Bool) {
//
//        newsTableView.reloadData()
//
//    }
>>>>>>> lesson3
}


extension NewsViewController : UITableViewDelegate, UITableViewDataSource{

<<<<<<< HEAD
=======
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let heighOfRow = cell.bounds.height
//                    print(heighOfRow)
//    }


>>>>>>> lesson3
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsModel.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
<<<<<<< HEAD
       return 3
=======
       return 4
>>>>>>> lesson2
=======
       return 4
>>>>>>> lesson3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

<<<<<<< HEAD
<<<<<<< HEAD
            if indexPath.row == 0 {
            guard let cellText = tableView.dequeueReusableCell(withIdentifier: textNewsCell, for: indexPath)
                    as? TextNewsCell else {return UITableViewCell()}

                cellText.config(meNews: newsModel.newsArray[indexPath.section])
            return cellText
            } else if indexPath.row == 1 {
                guard let cellImage = tableView.dequeueReusableCell(withIdentifier: imageNewsCell, for: indexPath)
                        as? ImageNewsCell else {return UITableViewCell()}

                cellImage.config(meNews: newsModel.newsArray[indexPath.section])
                return cellImage
            } else if indexPath.row == 2{
                guard let cellInfo = tableView.dequeueReusableCell(withIdentifier: infoNewsCell, for: indexPath)
                        as? InfoNewsCell else {return UITableViewCell()}

                cellInfo.config(meNews: newsModel.newsArray[indexPath.section])
                return cellInfo
            } else {return UITableViewCell()}

        }

=======
=======
>>>>>>> lesson3
        switch indexPath.row {

        case 0 :
            guard let cellTitle = tableView.dequeueReusableCell(withIdentifier: titleNewsCell, for: indexPath)
                    as? TitleNewsCell else {return UITableViewCell()}
            cellTitle.config(meNews: newsModel.newsArray[indexPath.section])
            return cellTitle

        case 1 :

            guard let cellText = tableView.dequeueReusableCell(withIdentifier: textNewsCell, for: indexPath)
                    as? TextNewsCell else {return UITableViewCell()}
            cellText.config(meNews: newsModel.newsArray[indexPath.section])
            return cellText

        case 2 :

            guard let cellImage = tableView.dequeueReusableCell(withIdentifier: imageNewsCell, for: indexPath)
                    as? ImageNewsCell else {return UITableViewCell()}
            cellImage.config(meNews: newsModel.newsArray[indexPath.section])

            return cellImage

        case 3 :

            guard let cellInfo = tableView.dequeueReusableCell(withIdentifier: infoNewsCell, for: indexPath)
                    as? InfoNewsCell else {return UITableViewCell()}
            cellInfo.config(meNews: newsModel.newsArray[indexPath.section])
            return cellInfo

        default:

            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
<<<<<<< HEAD
        case 0 :
            return 50
        case 1 :
            return UITableView.automaticDimension
        case 2 :
            return 350
        case 3 :
            return UITableView.automaticDimension
=======
        case 2 :
            return 360
>>>>>>> lesson3
        default:
            return UITableView.automaticDimension
        }

    }
    
<<<<<<< HEAD
>>>>>>> lesson2
=======
>>>>>>> lesson3
}

