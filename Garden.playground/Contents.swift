//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

/// testando commit nova no git
/// menu (jardim) inicial

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
        print("Apertou botao Maria")
        navigationController?.pushViewController(jogoViewController, animated: true)
    }
    
}

/// etapa de jogo

class JogoViewController : UIViewController {
    
    var listaPlantas = [UIButton]()
    var numeroDePlantas = 20
    
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
        
        fazAcontecer()
    }
    
    // faz plantas aparecerem na tela e sumirem, ou seja, o jogo acontecer
    func fazAcontecer() {
        // adicionar e apos 3 segundos some planta
        adicionaPlanta()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.somePlanta()
        })
    }
    
    @objc func somePlantaQuandoClica(_ sender: UIButton) {
        sender.alpha = 0
    }
    
    // adiciona planta a cada 1 segundo
    
    func adicionaPlanta() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            let xPosition = Int.random(in: 0..<1920)
            let plantaButton = UIButton(frame: CGRect(x: xPosition, y: 158, width: 228, height: 229))
            plantaButton.setImage(UIImage(named: "plantaFlor"), for: .normal)
            plantaButton.imageView?.contentMode = .scaleAspectFit
            
            plantaButton.addTarget(self, action: #selector(self.somePlantaQuandoClica(_:)), for: .touchUpInside)
            
            self.view.addSubview(plantaButton)
            
            self.listaPlantas.append(plantaButton)
        } )
    }
    
    // planta desaparecer
    
    func somePlanta() {
        let plantaSelecionada = self.listaPlantas[0]
        listaPlantas.remove(at: 0)
        UIView.animate(withDuration: 0.3, animations: {
            plantaSelecionada.alpha = 0
        }, completion: { _ in
            // tira elemento da view, para nao sobrecarregar
            plantaSelecionada.removeFromSuperview()
        })
    }
    
}

/// variaveis das paginas

let menuViewController = MenuViewController()
let jogoViewController = JogoViewController()

/// navegacao principal

let navigation = UINavigationController(screenType: .mac, isPortrait: true)
navigation.pushViewController(jogoViewController, animated: true)
navigation.navigationBar.isHidden = true

// configuracao de tamanho de tela
PlaygroundPage.current.liveView = navigation.scale(to: 0.3)
