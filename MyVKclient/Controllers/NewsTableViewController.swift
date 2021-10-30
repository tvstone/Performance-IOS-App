//
//  NewsTableViewController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 22.10.2021.
//

import UIKit
import RealmSwift
import Kingfisher

class NewsTableViewController: UITableViewController{

    @IBOutlet var newsTableView: UITableView!

    private let newsTableCellIdentifire = "newsTableCellIdentifire"
    private let textNewsCell = "textNewsCell"
    private let imageNewsCell = "imageNewsCell"
    private let infoNewsCell = "infoNewsCell"
    private let titleNewsCell = "titleNewsCell"
    private let networkNews = NetworkNews()
    private let networkGroup = NetworkGroup()
    private var newsModel = NewsModel()
    private var myNews = [News]()
    var newsIsLoaded = false
    var nextFrom = ""
    var isLoading = false


    fileprivate func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl?.tintColor = .gray
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)

    }
    @objc func refreshNews(){
        self.refreshControl?.beginRefreshing()
        let mostFreshNewsDate = Date().timeIntervalSince1970

        networkNews.newsRequest(startTime: mostFreshNewsDate + 1) { [weak self] news, nextFrom in
            guard let self = self else { return }

            self.refreshControl?.endRefreshing()
            guard news.count > 0 else { return }
            self.newsModel.newsArray = news + self.newsModel.newsArray
            let indexSet = IndexSet(integersIn: 0..<news.count)
            self.tableView.insertSections(indexSet, with: .automatic)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(UINib(nibName: "TextNewsCell", bundle: nil),
                               forCellReuseIdentifier: textNewsCell)
        newsTableView.register(UINib(nibName: "ImageNewsCell", bundle: nil),
                               forCellReuseIdentifier: imageNewsCell)
        newsTableView.register(UINib(nibName: "InfoNewsCell", bundle: nil),
                               forCellReuseIdentifier: infoNewsCell)
        newsTableView.register(UINib(nibName: "TitleNewsCell", bundle: nil),
                               forCellReuseIdentifier: titleNewsCell)

        tableView.prefetchDataSource = self

            networkNews.newsRequest {[weak self] news, nextFrom in
                guard let self = self else {return}
                self.newsModel.newsArray = news

                self.newsTableView.reloadData()
                self.nextFrom = nextFrom
                self.setupRefreshControl()

            }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       return newsModel.newsArray.count

    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
            
        case 2 :
            guard let width = Int(newsModel.newsArray[indexPath.section].width),
                  let height = Int(newsModel.newsArray[indexPath.section].height) else {return 360}
            let aspectRatio : CGFloat = CGFloat(height) / CGFloat(width)
            let tableWidth = tableView.bounds.width
            let cellHeight = tableWidth * aspectRatio
            return cellHeight
        default:
            return UITableView.automaticDimension
        }

    }


}
//MARK: Table View Data Sourse Prefetching
extension NewsTableViewController : UITableViewDataSourcePrefetching {


    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

               guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > newsModel.newsArray.count - 4,

                   !isLoading {
                   isLoading = true
                   networkNews.newsRequest(startFrom: nextFrom) { [weak self] (news, nextFrom) in
                       guard let self = self else { return }
                       let indexSet = IndexSet(integersIn: self.newsModel.newsArray.count ..< self.newsModel.newsArray.count + news.count)
                       self.newsModel.newsArray.append(contentsOf: news)
                       self.tableView.insertSections(indexSet, with: .automatic)
                       self.isLoading = false
                       self.nextFrom = nextFrom
                   }
               }
           }
    }




