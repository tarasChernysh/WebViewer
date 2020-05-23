//
//  LinkViewerVC.swift
//  WebViewer
//
//  Created by Taras Chernysh on 23.05.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit
import WebKit

protocol LinkViewerVCDelegate: class {
    func linkViewerVC(webView: WKWebView,
                      createWebViewWith configuration: WKWebViewConfiguration,
                      for navigationAction: WKNavigationAction,
                      windowFeatures: WKWindowFeatures)
    func linkViewerVC(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation)
    func linkViewerVC(webView: WKWebView, didFinish navigation: WKNavigation)
    func linkViewerVC(webView: WKWebView, didFail navigation: WKNavigation, withError error: Error)
}

final class LinkViewerVC: UIViewController {
    // MARK: - Properties
    private let webView: WKWebView = {
        let wv = WKWebView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.gray
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let linkContent: LinkContent
    // need to retain to live LinkerCoordinator
    private var delegate: LinkViewerVCDelegate
    
    // MARK: - Lifecycle
    init(linkContent: LinkContent, delegate: LinkViewerVCDelegate) {
        self.delegate = delegate
        self.linkContent = linkContent
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Setup
    func setupViewController() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        activityIndicator.hidesWhenStopped = true
        loadWebPage()
        setupLayout()
    }
    
    private func loadWebPage() {
        webView.load(linkContent.urlRequest)
    }
    
    private func setupLayout() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        
        let webViewCenterY = webView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let webViewCenterX = webView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let webViewWidth = webView.widthAnchor.constraint(equalTo: view.widthAnchor)
        let webViewHeight = webView.heightAnchor.constraint(equalTo: view.heightAnchor)
        
        [webViewCenterY, webViewCenterX, webViewWidth, webViewHeight].forEach { $0.isActive = true }
        
        let activityCenterY = activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let activityCenterX = activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let activityWidth = activityIndicator.widthAnchor.constraint(equalToConstant: GUI.indicatorWidth)
        let activityHeight = activityIndicator.heightAnchor.constraint(equalToConstant: GUI.indicatorHeight)
        
        [activityCenterY, activityCenterX, activityWidth, activityHeight].forEach { $0.isActive = true }
    }
    
    // MARK: - GUI
    private enum GUI {
        static let indicatorHeight: CGFloat = 30
        static let indicatorWidth: CGFloat = 30
    }
}

// MARK: - WKNavigationDelegate
extension LinkViewerVC: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        webView.load(navigationAction.request)
        delegate.linkViewerVC(webView: webView,
                              createWebViewWith: configuration,
                              for: navigationAction,
                              windowFeatures: windowFeatures)
        return nil
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        delegate.linkViewerVC(webView: webView, didStartProvisionalNavigation: navigation)
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delegate.linkViewerVC(webView: webView, didFinish: navigation)
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate.linkViewerVC(webView: webView, didFail: navigation, withError: error)
        activityIndicator.stopAnimating()
    }
}
