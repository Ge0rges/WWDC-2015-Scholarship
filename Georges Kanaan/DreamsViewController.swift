//
//  DreamsViewController.swift
//  Georges Kanaan
//
//  Created by Georges Kanaan on 4/26/15.
//
//

import UIKit

class DreamsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // Update the status bar
    self.setNeedsStatusBarAppearanceUpdate()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: - IBActions
  @IBAction func dismissView(sender: UIButton) {
    dismissViewControllerAnimated(true, completion: {})
  }
  
  //MARK: - Status Bar
  override func prefersStatusBarHidden() -> Bool {
    return true;
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent;
  }
}
