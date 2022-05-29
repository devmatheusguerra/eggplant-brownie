//
//  RefeicaoDao.swift
//  eggplant-brownie
//
//  Created by Matheus Guerra on 29/05/22.
//

import Foundation


class RefeicaoDao
{
    
    func recuperaDiretorio() -> URL?{
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let caminho = diretorio.appendingPathComponent("refeicao")
        
        return caminho
    }
    
    func save(_ refeicoes: Array<Refeicao>)
    {
        
        guard let caminho = recuperaDiretorio() else { return }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func recuperaDados() -> Array<Refeicao>
    {
        
        guard let caminho = recuperaDiretorio() else { return []}
        
        do{
            let dados = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else { return []}
            
            
            return refeicoesSalvas
            
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
