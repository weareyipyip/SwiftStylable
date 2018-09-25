//
//  ViewController.swift
//  StylableTest
//
//  Created by Marcel Bloemendaal on 10/08/2017.
//  Copyright © 2017 Marcel Bloemendaal. All rights reserved.
//

import UIKit
import SwiftStylable

class ViewController: UIViewController, UITextViewDelegate {
	@IBOutlet weak var textView: STTextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//self.textView.delegatie = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		print("check")
		return true
	}

	public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		print(text)
		return true
	}

}

