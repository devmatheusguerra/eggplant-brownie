//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Matheus Guerra on 05/05/22.
//

import UIKit

class Refeicao: NSObject, NSCoding {
    
    // MARK: - Atributos
    let nome: String
    let felicidade: Int
    var itens: Array<Item> = []
    
    // MARK: - Init
    
    init(nome: String, felicidade: Int, itens: Array<Item> = [])
    {
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(felicidade, forKey: "felicidade")
        coder.encode(itens, forKey: "itens")
    }
    
    required init?(coder: NSCoder) {
        nome =  coder.decodeObject(forKey: "nome") as! String
        felicidade = coder.decodeInteger(forKey: "felicidade")
        itens = coder.decodeObject(forKey: "itens") as! Array<Item>
    }
    
    
    // MARK: - Metodos
    func totalDeCalorias() -> Double
    {
        var total = 0.0
        
        for item in itens
        {
            total += item.calorias
        }
        
        return total
    }
    
    func detalhes() -> String
    {
        var mensagem = "Felicidade \(self.felicidade)\n"
        var contador = 1
        for item in self.itens
        {
            mensagem += "\(contador)º - \(item.nome)\n"
            contador += 1
        }
        
        mensagem += "Total de Calorias: \(self.totalDeCalorias())"
        
        return mensagem
    }

}
