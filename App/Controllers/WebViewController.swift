//
//  WebViewController.swift
//  UI Testing Cheat Sheet
//
//  Created by Joe Masilotti on 9/7/15.
//  Copyright © 2015 Masilotti.com. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = NSURL(string: "https://en.wikipedia.org/wiki/Volleyball") else { return }

        let request = NSURLRequest(url: url as URL)
        self.webView.loadRequest(request as URLRequest)
    }

    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
