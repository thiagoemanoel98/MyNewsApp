//
//  GenericDataProvider.swift
//  MyNewsApp
//
//  Created by Thiago Emanoel on 10/08/23.
//

import Foundation

// Protocolos definem comportamentos

protocol GenericDataProvider {
    func success(model: Any);
    func errorData(provide: GenericDataProvider?, error: Error);
}

class DataProviderManager<T, S> {
    var delegate: T?;
    var model: S?;
}
