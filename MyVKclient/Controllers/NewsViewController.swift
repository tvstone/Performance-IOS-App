//
//  NewsViewController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 06.07.2021.
//

import UIKit
import RealmSwift

final class NewsViewController: UIViewController {    
    
    @IBOutlet var newsTableView: UITableView!
    
    private let newsTableCellIdentifire = "newsTableCellIdentifire"
    private let textNewsCell = "textNewsCell"
    private let imageNewsCell = "imageNewsCell"
    private let infoNewsCell = "infoNewsCell"
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
        self.newsTableView.dataSource = self
        self.newsTableView.delegate = self
        newsTableView.reloadData()

        do {
            let realm = try Realm()
            let news = realm.objects(RealmNews.self)
            newsChangedToken = news.observe { chenge  in
                switch chenge{
                case .initial(let initial):
                print(initial)
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

    override func viewDidAppear(_ animated: Bool) {
        newsTableView.reloadData()
    }
}


extension NewsViewController : UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return newsModel.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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

}

