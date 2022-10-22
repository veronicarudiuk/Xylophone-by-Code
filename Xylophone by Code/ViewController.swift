//
//  ViewController.swift
//  Xylophone by Code
//
//  Created by Veronica Rudiuk on 22.10.22.
//

import UIKit
import SwiftUI
import AVFoundation

var player: AVPlayer!

class ViewController: UIViewController {
    
    //    создаю кнопки
    let cButton = UIButton(text: "C", color: UIColor.init(named: "C")!)
    let dButton = UIButton(text: "D", color: UIColor.init(named: "D")!)
    let eButton = UIButton(text: "E", color: UIColor.init(named: "E")!)
    let fButton = UIButton(text: "F", color: UIColor.init(named: "F")!)
    let gButton = UIButton(text: "G", color: UIColor.init(named: "G")!)
    let aButton = UIButton(text: "A", color: UIColor.init(named: "A")!)
    let bButton = UIButton(text: "B", color: UIColor.init(named: "B")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //        создаю вьюхи, помещаю в них кнопки и указываю боковое расстояние
        let cView = UIView(button: cButton, space: 5)
        let dView = UIView(button: dButton, space: 10)
        let eView = UIView(button: eButton, space: 15)
        let fView = UIView(button: fButton, space: 25)
        let gView = UIView(button: gButton, space: 30)
        let aView = UIView(button: aButton, space: 35)
        let bView = UIView(button: bButton, space: 40)
        
        //        добавляю вьюхи в стак вью
        let mainStackView = UIStackView(arrangedSubviews: [cView, dView, eView, fView, gView, aView, bView])
        
        //        добавляю стак на главную вьюху
        view.addSubview(mainStackView)
        
        //        настройка внешнего вида стек вью
        mainStackView.distribution = .fillEqually
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}


// расширение для дизайна кнопки с возможностью указывать текст и цвет
extension UIButton {
    convenience init(text: String, color: UIColor) {
        self.init()
        setTitle(text, for: .normal)
        backgroundColor = color
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel?.textColor = .white
        layer.cornerRadius = 20
        addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)

    }
    
// описание действий, которые запускает нажатие кнопки (звук + визуальный эффект нажатия)
    @objc func onClick(_ sender: UIButton!) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
        let url = Bundle.main.url(forResource: sender.currentTitle, withExtension: "wav")
        player = AVPlayer.init(url: url!)
        player.play()
    }
}

// расширение для вьюхи с возможностью указывать кнопку (которая будет внутри) и боковое расстояние
extension UIView {
    convenience init(button: UIButton, space: CGFloat) {
        self.init()
        backgroundColor = .none
        let button = button
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space).isActive = true
    }
}

// превью SwiftUI
struct SwiftUIController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

struct SwiftUIController_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIController()
    }
}

