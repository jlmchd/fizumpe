//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

// MARK: - menu (jardim) inicial

class MenuViewController : UIViewController {
    override func loadView() {
        
        let view = UIView()
        
        let fundoMenu = UIImage(named: "backgroundMenuImage")
        let fundoMenuView = UIImageView(image: fundoMenu)
        fundoMenuView.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        
        let mariaButton = UIButton(frame: CGRect(x: 138, y: 158, width: 228, height: 229))
        mariaButton.setImage(UIImage(named: "maria"), for: .normal)
        // linkar o botao a funcao chamaJogo
        mariaButton.addTarget(nil, action: #selector(chamaJogo), for: .touchUpInside)
        
        
        view.addSubview(fundoMenuView)
        view.addSubview(mariaButton)
        self.view = view
    }
    
    // disparo que chama outra tela
    @objc func chamaJogo() {
        navigationController?.pushViewController(jogoViewController, animated: true)
    }
    
}

// MARK: - etapa de jogo

class JogoViewController : UIViewController {
    
    var plantasClicadas = 0 {
        didSet {
            if self.plantasClicadas == 7 {
                navigationController?.pushViewController(menuFinalViewController, animated: true)
                
            }
        }
    }
    
    override func loadView() {
        let view = UIView()
        
        let fundoMenu = UIImage(named: "backgroundGameImage")
        let fundoMenuView = UIImageView(image: fundoMenu)
        fundoMenuView.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        
        let falaImage = UIImage(named:"falaMariaImage")
        let falaView = UIImageView(image: falaImage)
        falaView.frame = CGRect(x: 1080, y: 110, width: 740, height: 255)
        falaView.layer.zPosition = 1
        
        view.addSubview(fundoMenuView)
        view.addSubview(falaView)
        self.view = view
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fazAcontecer()
    }
    
    // faz plantas aparecerem na tela e sumirem, ou seja, o jogo acontecer
    func fazAcontecer() {
        
        let planta = adicionaPlanta()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.somePlanta(plantaSelecionada: planta)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            if self.plantasClicadas < 7 {
                self.fazAcontecer()
            }
        })
    }
    
    @objc func somePlantaQuandoClica(_ sender: UIButton) {
        sender.alpha = 0
        plantasClicadas += 1
    }
    
    // adiciona planta a cada 1 segundo
    func adicionaPlanta() -> UIButton {
        
        let xPosition = Int.random(in: 0..<1920)
        let yPosition = Int.random(in: 0..<1080)
        let plantaButton = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: 228, height: 229))
        plantaButton.setImage(UIImage(named: "plantaFlor"), for: .normal)
        plantaButton.imageView?.contentMode = .scaleAspectFit
        
        plantaButton.addTarget(self, action: #selector(self.somePlantaQuandoClica(_:)), for: .touchUpInside)
        
        self.view.addSubview(plantaButton)
        return plantaButton

    }
    
    // planta desaparecer
    func somePlanta(plantaSelecionada: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            plantaSelecionada.alpha = 0
        }, completion: { _ in
            // tira elemento da view, para nao sobrecarregar
            plantaSelecionada.removeFromSuperview()
        })
    }
    
}

// MARK: - menu final

class MenuFinalViewController : UIViewController {
    override func loadView() {
        
        let view = UIView()
        
        let popUpFinalButton = UIButton(frame: CGRect(x: 498, y: 298, width: 924, height: 484))
        popUpFinalButton.setImage(UIImage(named: "popUpFinalImage"), for: .normal)
        popUpFinalButton.addTarget(nil, action: #selector(clicarPopUpFinal(_:)), for: .touchUpInside)
        popUpFinalButton.adjustsImageWhenHighlighted = false
        
        let fundoMenu = UIImage(named: "backgroundMenuFinalImage")
        let fundoMenuView = UIImageView(image: fundoMenu)
        fundoMenuView.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        
        view.addSubview(fundoMenuView)
        view.addSubview(popUpFinalButton)
        self.view = view
    }
    
    @objc func clicarPopUpFinal(_ sender: UIButton)
    {
        sender.alpha = 0
    }
    
}

// MARK: - variaveis das paginas

let menuViewController = MenuViewController()
let jogoViewController = JogoViewController()
let menuFinalViewController = MenuFinalViewController()

// MARK: - navegacao principal

let navigation = UINavigationController(screenType: .mac, isPortrait: true)
navigation.pushViewController(menuViewController, animated: true)
navigation.navigationBar.isHidden = true

// configuracao de tamanho de tela
PlaygroundPage.current.liveView = navigation.scale(to: 0.3)
