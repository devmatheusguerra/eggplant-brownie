//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Matheus Guerra on 15/05/22.
//

import UIKit

protocol adicionarNovoItemDelegate
{
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    // MARK: - Atributos
    var delegate: adicionarNovoItemDelegate?
    
    // MARK: - Init
    init(delegate: adicionarNovoItemDelegate){
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
//        let Image = UIImage(named: "back.jpg")
//        let myImageView:UIImageView = UIImageView(image: Image)
//        myImageView.contentMode = UIView.ContentMode.scaleAspectFill
//        myImageView.frame.size.width = screenWidth * 2
//        myImageView.frame.size.height = screenHeight * 2
//        myImageView.center = self.view.center
//        view.addSubview(myImageView)
        
    }
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var caloriasTextField: UITextField?
    
    // MARK: - IBActions
    @IBAction func adicionarItem(_ sender: Any) {
        
        guard let nome = nomeTextField?.text,
                let calorias = caloriasTextField?.text,
              let numeroDeCalorias = Double(calorias) else { return }
            
        let item = Item(nome: nome, calorias: numeroDeCalorias)
        delegate?.add(item)
        
        navigationController?.popViewController(animated: true)
    }
    

  

}
