//
//  LinkerCoordinator.swift
//  WebViewer
//
//  Created by Taras Chernysh on 23.05.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit
import WebKit

public protocol LinkViewerCoordinatorDelegate: class {
    func linkViewerCoordinator(webView: WKWebView,
                               createWebViewWith configuration: WKWebViewConfiguration,
                               for navigationAction: WKNavigationAction,
                               windowFeatures: WKWindowFeatures)
    func linkViewerCoordinator(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation)
    func linkViewerCoordinator(webView: WKWebView, didFinish navigation: WKNavigation)
    func linkViewerCoordinator(webView: WKWebView, didFail navigation: WKNavigation, withError error: Error)
}

final public class LinkViewerCoordinator {
    private let content: LinkContent
    weak var viewController: UIViewController?
    private lazy var factory = LinkViewerFactory()
    private weak var delegate: LinkViewerCoordinatorDelegate?
    
    // MARK: - Controllers
    public init(content: LinkContent,
                controller: UIViewController,
                delegate: LinkViewerCoordinatorDelegate?) {
        self.viewController = controller
        self.content = content
    }
    
    public func start() {
        let linkerViewerVC = factory.makeLinkViewerVC(with: content, delegate: self)
        viewController?.navigationController?.pushViewController(linkerViewerVC, animated: true)
    }
}

extension LinkViewerCoordinator: LinkViewerVCDelegate {
    func linkViewerVC(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation) {
        delegate?.linkViewerCoordinator(webView: webView, didStartProvisionalNavigation: navigation)
    }
    
    func linkViewerVC(webView: WKWebView, didFinish navigation: WKNavigation) {
        delegate?.linkViewerCoordinator(webView: webView, didFinish: navigation)
    }
    
    func linkViewerVC(webView: WKWebView, didFail navigation: WKNavigation, withError error: Error) {
        delegate?.linkViewerCoordinator(webView: webView, didFail: navigation, withError: error)
    }
    
    func linkViewerVC(webView: WKWebView,
                      createWebViewWith configuration: WKWebViewConfiguration,
                      for navigationAction: WKNavigationAction,
                      windowFeatures: WKWindowFeatures) {
       
    }
}
