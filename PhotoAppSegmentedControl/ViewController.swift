//
//  ViewController.swift
//  PhotoAppSegmentedControl
//
//  Created by Bill on 9/13/20.
//  Copyright © 2020 Sched LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private static let segmentBackgroundColor = UIColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 0.065)
    // dark mode
//    UIColor(red: 222/255, green: 222/255, blue: 225/255, alpha: 0.08)
    private static let transparentImage: UIImage = {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, UIScreen.main.scale)
        segmentBackgroundColor.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let lineImg = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return lineImg.stretchableImage(withLeftCapWidth: 0, topCapHeight: 1)
    }()

    private func createPicker() -> UISegmentedControl {
        let control = UISegmentedControl(items: ["A longer title", "Today"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.apportionsSegmentWidthsByContent = true
        control.selectedSegmentIndex = 0
        control.setTitleTextAttributes(
            [
                NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .headline),
                NSAttributedString.Key.foregroundColor : UIColor.darkGray
            ],
            for: .normal
        )
        control.setTitleTextAttributes(
            [
//                NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .headline),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ],
            for: .selected
        )
        control.selectedSegmentTintColor = UIColor.black.withAlphaComponent(0.35)
//        control.setBackgroundImage(transparentImage, for: .normal, barMetrics: .default)
//        control.setBackgroundImage(coloredImage, for: .selected, barMetrics: .default)
        control.setDividerImage(Self.transparentImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        control.setDividerImage(Self.transparentImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        control.setDividerImage(Self.transparentImage, forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)

        return control
    }

    private let blurBar: UIVisualEffectView = {
//        let theView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .prominent), style: .label))
        let theView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        theView.layer.cornerRadius = 10
        theView.clipsToBounds = true
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        // add a border that's filled exactly the same as the segmented control
        let rimView = UIView()
        rimView.translatesAutoresizingMaskIntoConstraints = false
        rimView.layer.borderWidth = 4
        rimView.layer.cornerRadius = 12
        rimView.layer.borderColor = segmentBackgroundColor.cgColor
        rimView.isUserInteractionEnabled = false
        rimView.backgroundColor = nil

        theView.contentView.addSubview(rimView)

        NSLayoutConstraint.activate([
            rimView.topAnchor.constraint(equalTo: theView.contentView.topAnchor),
            rimView.bottomAnchor.constraint(equalTo: theView.contentView.bottomAnchor, constant: 1),
            rimView.leadingAnchor.constraint(equalTo: theView.contentView.leadingAnchor),
            rimView.trailingAnchor.constraint(equalTo: theView.contentView.trailingAnchor),
        ])

        return theView
    }()

    private let imageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "water-lily"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill

        return img
    }()

    private var picker: UISegmentedControl! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let outerPicker = createPicker()
        view.addSubview(outerPicker)

        outerPicker.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: -2).isActive = true
        outerPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(blurBar)
        let innerPicker = createPicker()
        blurBar.contentView.addSubview(innerPicker)
        let guide = blurBar.contentView.layoutMarginsGuide
        blurBar.contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        NSLayoutConstraint.activate([
            blurBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            guide.topAnchor.constraint(equalTo: innerPicker.topAnchor),
            guide.bottomAnchor.constraint(equalTo: innerPicker.bottomAnchor),
            guide.trailingAnchor.constraint(equalTo: innerPicker.trailingAnchor),
            guide.leadingAnchor.constraint(equalTo: innerPicker.leadingAnchor),

            innerPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65)
        ])
        picker = innerPicker
    }
}

