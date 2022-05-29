//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Matheus Guerra on 17/05/22.
//

import UIKit

class Alerta
{
    
    var controller: UIViewController
    
    init(controller: UIViewController)
    {
        self.controller = controller
    
    }
    
    func error(title: String, mensagem: String)
    {
        let alerta = UIAlertController(title: title, message: mensagem, preferredStyle: .alert)
        
        let botao = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alerta.addAction(botao)
        
        controller.present(alerta, animated: true, completion: nil)
        
    }
    
    
}
