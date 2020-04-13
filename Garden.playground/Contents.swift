//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

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
    override func loadView() {
        let view = UIView()
        
        let fundoMenu = UIImage(named: "backgroundGameImage")
        let fundoMenuView = UIImageView(image: fundoMenu)
        fundoMenuView.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        
        let falaImage = UIImage(named:"falaMariaImage")
        let falaView = UIImageView(image: falaImage)
        falaView.frame = CGRect(x: 1080, y: 110, width: 740, height: 255)
         
        view.addSubview(fundoMenuView)
        view.addSubview(falaView)
        self.view = view
        
    }
}

/// variaveis das paginas

let menuViewController = MenuViewController()
let jogoViewController = JogoViewController()

/// navegacao principal

let navigation = UINavigationController(screenType: .mac, isPortrait: true)
navigation.pushViewController(menuViewController, animated: true)
navigation.navigationBar.isHidden = true

// configuracao de tamanho de tela
PlaygroundPage.current.liveView = navigation.scale(to: 0.3)
