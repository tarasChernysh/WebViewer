//
//  LinkContent.swift
//  WebViewer
//
//  Created by Taras Chernysh on 23.05.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

public struct LinkContent {
    public let url: URL
    public let title: String
    
    public init(url: URL, title: String) {
        self.url = url
        self.title = title
    }
}

extension LinkContent {
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
}
