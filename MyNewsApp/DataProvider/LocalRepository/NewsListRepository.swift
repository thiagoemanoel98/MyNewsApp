//
//  NewsListRepository.swift
//  MyNewsApp
//
//  Created by Thiago Emanoel on 10/08/23.
//

import Foundation

enum NewsListError: Error {
    case fileNotFound
}

class NewsListRepository {
    //singleton - classe com uma unica instancia de si mesma
    static var shared: NewsListRepository = {
        let instance = NewsListRepository();
        return instance;
    }();
    
    // Garantir que nao vao criar outra instancia dela
    private init(){}
    
    func getNewsList(completetion: ([NewsModel]?, Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "NewsList", ofType: "json") {
            do{
                let url = URL(fileURLWithPath: path);
                let data = try Data(contentsOf: url, options: .mappedIfSafe);
                
                let decoder = JSONDecoder();
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso860Full)
                let newsModelList = try decoder.decode([NewsModel].self, from: data);
                
                completetion(newsModelList, nil);
            } catch {
                print("\(error)");
                completetion(nil, error);
            }
        } else {
            completetion(nil, NewsListError.fileNotFound)
        }
    }
}

// Conseguem mudar o coportamento ate de libs internas do ios
// Mudar o comportamento do DateFormatter
extension DateFormatter {
    static let iso860Full: DateFormatter = {
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        return formatter;
    }()
}
