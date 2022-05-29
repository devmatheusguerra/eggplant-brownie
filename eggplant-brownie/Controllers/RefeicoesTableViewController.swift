//
//  Refeicoes.swift
//  eggplant-brownie
//
//  Created by Matheus Guerra on 15/05/22.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, adicionaRefeicaoDelegate {
    
    var refeicoes: Array<Refeicao> = []
    var empty = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refeicaoSalva = RefeicaoDao().recuperaDados()
        refeicoes = refeicaoSalva
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if refeicoes.count == 0
        {
            empty = true
            return 1
        }
        else
        {
            empty = false
            return refeicoes.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        if (empty)
        {
            celula.textLabel?.text = "Sem refeições..."
        }else{
            let refeicao = refeicoes[indexPath.row]
            celula.textLabel?.text = refeicao.nome
            celula.detailTextLabel?.text = "\(refeicao.totalDeCalorias()) calorias"
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
            celula.addGestureRecognizer(longPress)
            
        }
        
        return celula
        
    }
                                
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer)
    {
        if gesture.state == .began
        {
            let celula = gesture.view as! UITableViewCell
            
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            
            let refeicao = refeicoes[indexPath.row]
            
            let alerta = UIAlertController(title: "\(refeicao.nome)", message: refeicao.detalhes(), preferredStyle: .alert)
            
            let botaoCancelar = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            let botaoExcluir = UIAlertAction(title: "Apagar", style: .destructive, handler: {
                alerta in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
            
            alerta.addAction(botaoExcluir)
            alerta.addAction(botaoCancelar)
            
            present(alerta, animated: true, completion: nil)
            
        }
                
    }
    
    
    func add(_ refeicao: Refeicao)
    {
        refeicoes.append(refeicao)
        RefeicaoDao().save(refeicoes)
        tableView.reloadData()
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController
        {
            viewController.delegate = self
        }
    }
    
}
