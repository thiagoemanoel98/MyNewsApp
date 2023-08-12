//
//  NewsListViewController.swift
//  MyNewsApp
//
//  Created by Thiago Emanoel on 10/08/23.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var newsListTableView: UITableView! {
        didSet {
            self.setupTableView();
        }
    };
    
    private var newsList: [NewsModel]? {
        didSet {
            self.newsListTableView.reloadData();
        }
    };
    
    var localDataProvider: NewsListLocalDataProvider? {
        didSet {
            self.newsListTableView.reloadData();
        }
    };
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.setupTableView();
        self.initLocalDataProvider();
    }
    
    private func setupTableView(){
        self.newsListTableView.delegate = self;
        self.newsListTableView.dataSource = self;
        self.newsListTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell");
    }
    
    private func initLocalDataProvider(){
        self.localDataProvider = NewsListLocalDataProvider();
        
        // A propria viewcontroller implementa o delegate dele
        self.localDataProvider?.delegate = self;
        self.localDataProvider?.getNewsList();
    }
}

// Organização

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectowAt")
    }
}

// Rever aula 3
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else { fatalError("Unable to dequeue subclassed cell") }
        
        guard let newsList = newsList else {
            fatalError("Unable news");
        }
        
        cell.news = newsList[indexPath.row]
        
        return cell;
    }
}

extension NewsListViewController: NewsListLocalDataProviderProtocol {
    func success(model: Any) {
        self.newsList = model as? [NewsModel];
        // atualizar a tableview
        self.newsListTableView.reloadData();
    }
    
    func errorData(provide: GenericDataProvider?, error: Error) {
        print("\(error.localizedDescription)");
    }
}
