//
//  LinkerFactory.swift
//  WebViewer
//
//  Created by Taras Chernysh on 23.05.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

protocol LinkViewerFactoryProtocol {
    func makeLinkViewerVC(with content: LinkContent, delegate: LinkViewerVCDelegate) -> LinkViewerVC
}

final class LinkViewerFactory: LinkViewerFactoryProtocol {
    func makeLinkViewerVC(with content: LinkContent, delegate: LinkViewerVCDelegate) -> LinkViewerVC {
        let vc = LinkViewerVC(linkContent: content, delegate: delegate)
        return vc
    }
}
