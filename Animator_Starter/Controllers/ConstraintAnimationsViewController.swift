//
//  ConstraintAnimationsViewController.swift
//  Animator_Starter
//

//

import UIKit

class ConstraintAnimationsViewController: UIViewController {
    
    // MARK: Storyboard outlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var newsletterView: UIView!
    @IBOutlet weak var welcomeCenterX: NSLayoutConstraint!
    @IBOutlet weak var newsletterCenterX: NSLayoutConstraint!
    
    // MARK: Additional variables
    var newsletterInfoLabel = UILabel()
    var animManager: AnimationManager!
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Programmatic views
        newsletterInfoLabel.backgroundColor = .clear
        newsletterInfoLabel.text = "Help us make your animation code that much better by subscribing to our weekly newsletter! \n\n It's free and you can unsubscribe any time without hurting our feelings...much."
        newsletterInfoLabel.font = UIFont(name: "Bodoni 72 Oldstyle", size: 15)
        newsletterInfoLabel.textColor = .darkGray
        newsletterInfoLabel.textAlignment = .center
        newsletterInfoLabel.alpha = 0
        newsletterInfoLabel.backgroundColor = .clear
        newsletterInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        newsletterInfoLabel.numberOfLines = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: Offscreen positioning
        animManager = AnimationManager(activeConstrainst: [welcomeCenterX, newsletterCenterX])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Fire initial animations
        animateViewsOnScreen()
    }
    
    // MARK: Actions
    
    @IBAction func infoOnButtonPressed(_ sender: UIButton) {
        animateNewsletterHeight()
        animateWelcomeLabel()
    }
    
    // MARK: Animations
    
    func animateViewsOnScreen() {
        UIView.animate(withDuration: 1.5, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: [.curveEaseInOut]) {
            
            self.welcomeCenterX.constant = self.animManager.constraintOrigins[0]
            self.newsletterCenterX.constant = self.animManager.constraintOrigins[1]
            self.view.layoutIfNeeded()
            
        }
    }
    
    func animateNewsletterHeight() {
        
        if let heightConstraint = newsletterView.returnConstraint(withID: "NewsletterHeight") {
            print(heightConstraint.description)
            heightConstraint.constant = 350
        } else {
            print("No Constraint")
        }
        
        UIView.animate(withDuration: 1.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.addDynamicInfoLabel()
        }
        
    }
    
    func animateWelcomeLabel() {
        let modifiedWelcomeTop = NSLayoutConstraint(item: welcomeLabel, attribute: .top, relatedBy: .equal, toItem: welcomeLabel.superview, attribute: .top, multiplier: 1, constant: 100)
        
        if let welcomeTop = view.returnConstraint(withID: "WelcomeLabelTop") {
            print(welcomeTop.description)
            welcomeTop.isActive = false
            modifiedWelcomeTop.isActive = true
        }
        
        UIView.animate(withDuration: 0.75) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addDynamicInfoLabel() {
        newsletterView.addSubview(newsletterInfoLabel)
        
        let xAnchor = newsletterInfoLabel.centerXAnchor.constraint(equalTo: newsletterView.leftAnchor, constant: -75)
        let yAnchor = newsletterInfoLabel.centerXAnchor.constraint(equalTo: newsletterView.centerXAnchor)
        let widthAnchor = newsletterInfoLabel.widthAnchor.constraint(equalTo: newsletterView.widthAnchor, multiplier: 0.75)
        let heightAnchor = newsletterInfoLabel.heightAnchor.constraint(equalTo: newsletterInfoLabel.widthAnchor)
        
        NSLayoutConstraint.activate([xAnchor, yAnchor, widthAnchor, heightAnchor])
        self.view.layoutIfNeeded()
        
        //TODO: Animate label
        UIView.animate(withDuration: 1.0) {
            xAnchor.constant = self.newsletterView.frame.size.width/2
            self.newsletterInfoLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

}


// MARK: Extension UIView
extension UIView {
    
    func returnConstraint(withID: String) -> NSLayoutConstraint? {
        var constraintSearch: NSLayoutConstraint!
        
        for constraint in self.constraints {
            if constraint.identifier == withID {
                constraintSearch = constraint
            }
        }
        
        return constraintSearch
    }
    
}
