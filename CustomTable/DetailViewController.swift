//
//  DetailViewController.swift
//  CustomTable
//
//  Created by TA Trung Thanh on 08/12/2018.
//  Copyright © 2018 TA Trung Thanh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private var myValue = ""
    private let l = UILabel()
    private let i = UIImageView()
    
    convenience init (str: String, img: UIImage) {
        self.init()
        myValue = str
        i.image = img
        if UIDevice.current.userInterfaceIdiom == .phone {
            i.bounds.size = CGSize(width: 250, height: 250)
        } else {
            i.bounds.size = CGSize(width: 500, height: 500)
        }
    }
    
    override func viewDidLoad() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        l.text = "Detail view for "+myValue
        l.textAlignment = .center
        self.view.addSubview(l)
        self.view.addSubview(i)
        self.navigationItem.title = "Detail ("+myValue+")"
        self.displayInSize(UIScreen.main.bounds.size)
    }
    
    func displayInSize(_ s : CGSize) {
        if s.width > s.height && UIDevice.current.userInterfaceIdiom == .phone {
            l.frame = CGRect(x: 10, y: s.height/4, width: s.width, height: 40)
            i.frame = CGRect(x: s.width/4*3 - i.frame.size.width/2, y: s.height/2 - i.frame.size.height/2, width: i.frame.size.width, height: i.frame.size.height)
        } else {
            l.frame = CGRect(x: 10, y: 100, width: s.width, height: 40)
            i.frame = CGRect(x: s.width/2 - i.frame.size.width/2, y: s.height/2 - i.frame.size.height/2, width: i.frame.size.width, height: i.frame.size.height)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.displayInSize(size)
    }
}
