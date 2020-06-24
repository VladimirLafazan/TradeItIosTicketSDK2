import UIKit
import WebKit


class TradeItWebViewController: CloseableViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url = ""
    var pageTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = WKWebView()
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        self.webView.navigationDelegate = self
        self.navigationItem.title = "Loading...";
        guard let urlObject = URL (string: self.url) else {
            print("TradeIt SDK ERROR: Invalid url provided: " + self.url)
            _ = self.navigationController?.popViewController(animated: true)
            return
        }
        self.webView.load(URLRequest(url: urlObject))
    }

    // MARK: WKWebViewDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = self.pageTitle
    }
}
