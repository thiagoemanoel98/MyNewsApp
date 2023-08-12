//
//  NewsListLocalDataProvider.swift
//  MyNewsApp
//
//  Created by Thiago Emanoel on 11/08/23.
//

import Foundation

protocol NewsListLocalDataProviderProtocol: GenericDataProvider {};

class NewsListLocalDataProvider: DataProviderManager<NewsListLocalDataProviderProtocol,
NewsModel>{
  
    // Essa função retorna uma lista de noticias ou um erro
    func getNewsList() {
        NewsListRepository.shared.getNewsList { newModelList, error in
            if let error = error {
                self.delegate?.errorData(provide: self.delegate, error: error)
                return;
            }
            
            if let model = newModelList {
                self.delegate?.success(model: model)
            }
        }

    }
  
}

