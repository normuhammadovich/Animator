//
//  ViewController.swift
//  Animator_Starter
//
//

import UIKit

class BasicAnimationViewController: UIViewController {
    
    // MARK: Storyboard outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var graphic: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UI setup
        graphic.round(cornerRadius: graphic.frame.size.width/2, borderWidth: 3.0, borderColor: .black)
        
        // TODO: Animation setup
        titleLabel.alpha = 0
        graphic.alpha = 0
        loadingLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Fire initial animations
        animateTitleLabelIn()
        animateGraphicIn()

    }
    
    // MARK: AnimateTitleLabelIn
    func animateTitleLabelIn() {
        UIView.animate(withDuration: 1.5) {
            self.titleLabel.alpha = 1
            self.titleLabel.frame.origin.y -= 50
        }
    }
    
    //MARK: AnimateGraphicIn
    func animateGraphicIn() {
        UIView.animate(withDuration: 1.5, delay: 0.75, options: [.curveEaseInOut]) {
            self.graphic.alpha = 1
            self.graphic.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { completed in
            self.animateLoadingLabelPulse()
            self.segueToNextViewController(segueID: Constants.Segues.toSpringsVC, delay: 3.0)
        }
        
    }
    
    //MARK: AnimateLoadingLabelPulse
    func animateLoadingLabelPulse() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse]) {
            self.loadingLabel.alpha = 1
            self.loadingLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    
    
}

