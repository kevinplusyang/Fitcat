//
//  selectBcsController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/2/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit
import Alamofire

class SelectBcsController: UIViewController, UITextViewDelegate {

    let bcs5 = UIButton()
    let bcs7 = UIButton()
    let bcs9 = UIButton()
    let bcs5Bottom = UIButton()
    let bcs7Bottom = UIButton()
    let bcs9Bottom = UIButton()
    let stackView = UIStackView()
    let individualButton = UIButton()
    let superimposedButton = UIButton()
    let continueButton = UIButton()
    let bcsDescription = UITextView()
    let individualView = UIView()
    let superimposedView = UIView()
    let bcs5SideView = UIImageView(image: UIImage(named: "BCS5-sideview"))
    let bcs5TopView = UIImageView(image: UIImage(named: "BCS5-topview"))
    let bcs7SideView = UIImageView(image: UIImage(named: "BCS7-sideview"))
    let bcs7TopView = UIImageView(image: UIImage(named: "BCS7-topview"))
    let bcs9SideView = UIImageView(image: UIImage(named: "BCS9-sideview"))
    let bcs9TopView = UIImageView(image: UIImage(named: "BCS9-topview"))
    var superImposedImageView = UIImageView(image: UIImage(named: "superimposed"))
    let backgroundLineUnderTopButtons = CALayer()
    let selectedBackgroundLineUnderTopButtons = CALayer()

    //New Cat Parameters
    var catImageData: Data?
    var catName: String?
    var catBirthday: Date?
    var catBreed: String?
    var catWeight: Double?
    var catNeutered: Int? //0 is False, 1 is True
    var catGender: Int = 1 //1 is male, 2 is female
    var catBCS: Int?


    override func viewDidLoad() {
        if let catName = catName {
            title = "Select a BCS for \(catName)"
        } else { title = "Select a BCS" }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        let backImage = UIImage(named: "backBtn")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.tintColor = .white

        backgroundGradient()
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpView() {
        let navBarHeight = navigationController!.navigationBar.bounds.maxY

        //Continue Button
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        continueButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        continueButton.center.x = view.center.x
        continueButton.layer.borderWidth = 2.0
        continueButton.layer.borderColor = UIColor.white.cgColor
        continueButton.layer.cornerRadius = 7
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        continueButton.alpha = 0.4
        view.addSubview(continueButton)

        //Individual and Superimposed Buttons
        let widthOfButtons = view.bounds.width * 0.40
        let combinedWidthWithSpacing = (widthOfButtons * 2.0) + 30.0
        let indentationOfButtons = (view.bounds.width - combinedWidthWithSpacing) / 2.0
        let centerForButtons = (view.bounds.height * 0.08) + navBarHeight

        individualButton.backgroundColor = UIColor.clear
        individualButton.setTitle("Individual", for: .normal)
        individualButton.setTitleColor(.white, for: .normal)
        individualButton.setTitleColor(.lightGray, for: .highlighted)
        individualButton.frame = CGRect(x: indentationOfButtons, y: 0.0, width: widthOfButtons, height: 26.0)
        individualButton.layer.cornerRadius = individualButton.bounds.height / 2.0
        individualButton.center.y = centerForButtons
        individualButton.addTarget(self, action: #selector(clickedTopButtons), for: .touchUpInside)
        individualButton.tag = 2
        view.addSubview(individualButton)





        superimposedButton.backgroundColor = UIColor.clear
        superimposedButton.setTitle("Superimposed", for: .normal)
        superimposedButton.setTitleColor(.white, for: .normal)
        superimposedButton.setTitleColor(.lightGray, for: .highlighted)
        superimposedButton.alpha = 0.4
        superimposedButton.frame = CGRect(x: individualButton.frame.maxX + 30.0, y: 0.0, width: widthOfButtons, height: 26.0)
        superimposedButton.center.y = centerForButtons
        superimposedButton.addTarget(self, action: #selector(clickedTopButtons), for: .touchUpInside)
        superimposedButton.tag = 3
        view.addSubview(superimposedButton)

        backgroundLineUnderTopButtons.frame = CGRect(x: continueButton.frame.minX, y: superimposedButton.frame.maxY + 3.0, width: continueButton.bounds.width, height: 1.0)
        backgroundLineUnderTopButtons.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.4).cgColor
        view.layer.addSublayer(backgroundLineUnderTopButtons)

        selectedBackgroundLineUnderTopButtons.frame = CGRect(x: continueButton.frame.minX, y: superimposedButton.frame.maxY + 3.0, width: continueButton.bounds.width / 2.0, height: 1.0)
        selectedBackgroundLineUnderTopButtons.backgroundColor = UIColor.white.cgColor
        view.layer.addSublayer(selectedBackgroundLineUnderTopButtons)

        //bcs 5 7 9
        let contentHeight = (bcsDescription.frame.minY - individualButton.frame.maxY) - 30.0 //15 on each end

        bcs5.addTarget(self, action: #selector(pressedBCSButton(sender:)), for: .touchUpInside)
        bcs5.tag = 0
        bcs5.layer.cornerRadius = 5
        bcs5.backgroundColor = UIColor(red:255/255.0,green:255/255.0,blue:255/255.0,alpha: 0.5)
        bcs5.layer.borderWidth = 2
        bcs5.layer.borderColor = UIColor.clear.cgColor
        bcs5.frame = CGRect(x: continueButton.frame.minX, y: individualButton.frame.maxY + 15.0, width: continueButton.bounds.width, height: 70.0)
        bcs5SideView.frame = CGRect(x: bcs5.frame.minX, y: bcs5.frame.minY + 3.0, width: bcs5.bounds.width / 2.0, height: bcs5.bounds.height - 3.0)
        bcs5TopView.frame = CGRect(x: bcs5.frame.minX + bcs5.bounds.width / 2.0, y: bcs5.frame.minY + 3.0, width: bcs5.bounds.width / 2.0, height: bcs5.bounds.height - 3.0)
        bcs5TopView.contentMode = .scaleAspectFit
        bcs5SideView.contentMode = .scaleAspectFit


        view.addSubview(bcs5)
        view.addSubview(bcs5SideView)
        view.addSubview(bcs5TopView)


        bcs7.addTarget(self, action: #selector(pressedBCSButton(sender:)), for: .touchUpInside)
        bcs7.tag = 1
        bcs7.layer.cornerRadius = 5
        bcs7.backgroundColor = UIColor(red:255/255.0,green:255/255.0,blue:255/255.0,alpha: 0.5)
        bcs7.layer.borderWidth = 2
        bcs7.layer.borderColor = UIColor.clear.cgColor
        bcs7.frame = CGRect(x: continueButton.frame.minX, y: bcs5.frame.maxY + 10.0, width: continueButton.bounds.width, height: 70.0)
        bcs7SideView.frame = CGRect(x: bcs7.frame.minX, y: bcs7.frame.minY + 3.0, width: bcs7.bounds.width / 2.0, height: bcs7.bounds.height - 3.0)
        bcs7TopView.frame = CGRect(x: bcs7.frame.minX + bcs7.bounds.width / 2.0, y: bcs7.frame.minY + 3.0, width: bcs7.bounds.width / 2.0, height: bcs7.bounds.height - 3.0)
        bcs7TopView.contentMode = .scaleAspectFit
        bcs7SideView.contentMode = .scaleAspectFit

        view.addSubview(bcs7)
        view.addSubview(bcs7SideView)
        view.addSubview(bcs7TopView)

        bcs9.addTarget(self, action: #selector(pressedBCSButton(sender:)), for: .touchUpInside)
        bcs9.tag = 2
        bcs9.layer.cornerRadius = 5
        bcs9.backgroundColor = UIColor(red:255/255.0,green:255/255.0,blue:255/255.0,alpha: 0.5)
        bcs9.layer.borderWidth = 2
        bcs9.layer.borderColor = UIColor.clear.cgColor
        bcs9.frame = CGRect(x: continueButton.frame.minX, y: bcs7.frame.maxY + 10.0, width: continueButton.bounds.width, height: 70.0)
        bcs9SideView.frame = CGRect(x: bcs9.frame.minX, y: bcs9.frame.minY + 3.0, width: bcs9.bounds.width / 2.0, height: bcs9.bounds.height - 3.0)
        bcs9TopView.frame = CGRect(x: bcs9.frame.minX + bcs9.bounds.width / 2.0, y: bcs9.frame.minY + 3.0, width: bcs9.bounds.width / 2.0, height: bcs9.bounds.height - 3.0)
        bcs9TopView.contentMode = .scaleAspectFit
        bcs9SideView.contentMode = .scaleAspectFit

        view.addSubview(bcs9)
        view.addSubview(bcs9SideView)
        view.addSubview(bcs9TopView)



        superimposedView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        superimposedView.isHidden = true
        superimposedView.layer.cornerRadius = 5
        superimposedView.frame = CGRect(x: bcs5.frame.minX, y: bcs5.frame.minY, width: bcs5.bounds.width, height: 250.0)
        superImposedImageView.contentMode = .scaleAspectFit
        superImposedImageView.contentMode = .center
        superimposedView.addSubview(superImposedImageView)
        view.addSubview(superimposedView)

        stackView.frame = CGRect(x: continueButton.frame.minX, y: bcs9.frame.maxY + 20.0, width: continueButton.bounds.width, height: 40)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 5
        let bottomButtonArray = [bcs5Bottom, bcs7Bottom, bcs9Bottom]
        bcs5Bottom.setTitle("BCS 5", for: .normal)
        bcs7Bottom.setTitle("BCS 7", for: .normal)
        bcs9Bottom.setTitle("BCS 9", for: .normal)
        bcs5Bottom.tag = 5
        bcs7Bottom.tag = 7
        bcs9Bottom.tag = 9


        for button in bottomButtonArray {
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.gray, for: .highlighted)
            button.backgroundColor = UIColor.clear
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.clear.cgColor
            button.layer.cornerRadius = button.bounds.height / 2.0
            button.alpha = 0.4
            button.sizeToFit()
            button.contentEdgeInsets.left = 10
            button.contentEdgeInsets.right = 10
            button.addTarget(self, action: #selector(didSelectBottomButtons), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }


        //bcs textField
        bcsDescription.delegate = self
        bcsDescription.isEditable = false
        bcsDescription.isSelectable = false
        bcsDescription.isScrollEnabled = false
        //let width = UIScreen.main.bounds.width <= 320 ? frame.size.width * 0.85 : frame.size.width * 0.70
        bcsDescription.font = UIScreen.main.bounds.width <= 320 ? UIFont.systemFont(ofSize: 12): UIFont.systemFont(ofSize: 16)
        let heightExtender = UIScreen.main.bounds.width <= 320 ? 3.0 : 8.0
        bcsDescription.frame = CGRect(x: 0, y: stackView.frame.maxY + CGFloat(heightExtender), width: buttonWidth, height: continueButton.frame.minY - stackView.frame.maxY)
        bcsDescription.center.x = view.center.x
        bcsDescription.textColor = .white
        bcsDescription.text = ""
        bcsDescription.backgroundColor = UIColor.clear
        view.addSubview(bcsDescription)


        view.addSubview(stackView)

    }

    func didSelectBottomButtons(sender: UIButton) {
        let bcs = sender.tag
        clickedBCS(bcs: bcs)

    }

    func resetBottomButtons() {
        bcs5Bottom.layer.borderColor = UIColor.clear.cgColor
        bcs5Bottom.alpha = 0.4
        bcs7Bottom.layer.borderColor = UIColor.clear.cgColor
        bcs7Bottom.alpha = 0.4
        bcs9Bottom.layer.borderColor = UIColor.clear.cgColor
        bcs9Bottom.alpha = 0.4
    }


    //background gradient color
    func backgroundGradient(){
        let bottomColor = UIColor(red:227/255.0,green:70/255.0,blue:51/255.0,alpha: 1)
        let topColor = UIColor(red:228/255.0,green:100/255.0,blue:73/255.0,alpha: 1)
        let gradientColors:[CGColor] = [topColor.cgColor, bottomColor.cgColor,topColor.cgColor, bottomColor.cgColor]
        let gradientLocations:[Float] = [0.0,1.0]
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer,at: 0)
    }


    func clickedTopButtons(sender: UIButton) {
        let tag = sender.tag
        superimposedButton.alpha = tag == 3 ? 1.0 : 0.4
        individualButton.alpha = tag == 2 ? 1.0 : 0.4

        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            self.selectedBackgroundLineUnderTopButtons.frame =
                tag == 2 ? CGRect(x: self.continueButton.frame.minX, y: self.superimposedButton.frame.maxY + 3.0, width: self.continueButton.bounds.width / 2.0, height: 1.0) : CGRect(x: self.backgroundLineUnderTopButtons.frame.midX, y: self.superimposedButton.frame.maxY + 3.0, width: self.continueButton.bounds.width / 2.0, height: 1.0)

        }, completion: nil)

        //MARK FIX THIS AUSTIN WHY YOU GOTTA DO SLOPPY CODE
        bcs5.isHidden = tag == 2 ? false : true
        bcs5TopView.isHidden = tag == 2 ? false : true
        bcs5SideView.isHidden = tag == 2 ? false : true
        bcs7.isHidden = tag == 2 ? false : true
        bcs7TopView.isHidden = tag == 2 ? false : true
        bcs7SideView.isHidden = tag == 2 ? false : true
        bcs9.isHidden = tag == 2 ? false : true
        bcs9TopView.isHidden = tag == 2 ? false : true
        bcs9SideView.isHidden = tag == 2 ? false : true
        superimposedView.isHidden = tag == 2 ? true : false

        //Check to see which button was clicked and change the views.

    }

    func pressedBCSButton(sender: UIButton) {

        if sender.tag == 0 {
            clickedBCS(bcs: 5)
        } else if sender.tag == 1 {
            clickedBCS(bcs: 7)
        } else {
            clickedBCS(bcs: 9)
        }

    }
    func clickedBCS(bcs: Int) {
        bcs5.layer.borderColor = UIColor.clear.cgColor
        bcs7.layer.borderColor = UIColor.clear.cgColor
        bcs9.layer.borderColor = UIColor.clear.cgColor
        resetBottomButtons()

        let bcsDescriptions = [("BCS 5", "Spine, ribs, and pelvic bones not visible but easily felt, evenly distributed muscle mass, minimal abdominal fat with abdominal tuck."), ("BCS 7", "Spine, ribs, and pelvic bones not easily felt with moderate fat layer covering them, waist diminished, abdomen rounded with moderate abdominal fat pad."),("BCS 9", "Spine, ribs, and pelvic bones cannot be felt, excessive abdominal fat, waist absent.")]

        if bcs == 5 {
            catBCS = 5
            bcs5.layer.borderColor = UIColor.white.cgColor
            bcsDescription.text = bcsDescriptions[0].1
            bcs5Bottom.layer.borderColor = UIColor.white.cgColor
            bcs5Bottom.alpha = 1.0
            bcs5Bottom.layer.cornerRadius = bcs5Bottom.bounds.height / 2.0
            superImposedImageView.image = #imageLiteral(resourceName: "bcs5-outline")
        } else if bcs == 7 {
            catBCS = 7
            bcs7.layer.borderColor = UIColor.white.cgColor
            bcsDescription.text = bcsDescriptions[1].1
            bcs7Bottom.layer.borderColor = UIColor.white.cgColor
            bcs7Bottom.alpha = 1.0
            bcs7Bottom.layer.cornerRadius = bcs5Bottom.bounds.height / 2.0
            superImposedImageView.image = #imageLiteral(resourceName: "bcs7-outline")
        } else {
            catBCS = 9
            bcs9.layer.borderColor = UIColor.white.cgColor
            bcsDescription.text = bcsDescriptions[2].1
            bcs9Bottom.layer.borderColor = UIColor.white.cgColor
            bcs9Bottom.alpha = 1.0
            bcs9Bottom.layer.cornerRadius = bcs5Bottom.bounds.height / 2.0
            superImposedImageView.image =  #imageLiteral(resourceName: "bcs9-outline")
        }
        superImposedImageView.reloadInputViews()

        continueButton.setTitleColor(.lightGray, for: .highlighted)
        continueButton.alpha = 1.0
    }

    //continue button
    func continueButtonClicked(_ sender: UIButton) {
        if continueButton.alpha == 1.0 {
            let tipsVC = TipsViewController()
            tipsVC.catName = catName
            tipsVC.catBCS = catBCS
            tipsVC.catBirthday = catBirthday
            tipsVC.catBreed = catBreed
            tipsVC.catWeight = catWeight
            tipsVC.catNeutered = catNeutered
            tipsVC.catGender = catGender
            tipsVC.catImageData = catImageData
            navigationController?.pushViewController(tipsVC, animated: true)
            //self.present(vc, animated: true, completion: nil)




        }



    }
}

