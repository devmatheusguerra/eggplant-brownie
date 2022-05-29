//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Matheus Guerra on 05/05/22.
//

import UIKit

protocol adicionaRefeicaoDelegate
{
    func add(_ refeicao: Refeicao)
}


class ViewController: UIViewController,
                        UITableViewDataSource,
                            UITableViewDelegate,
                            adicionarNovoItemDelegate {
    
    // MARK: - Atributos
    var delegate: adicionaRefeicaoDelegate?
    var itens: Array<Item> = [Item(nome: "Molho de Tomate", calorias: 50.4),
                              Item(nome: "Ketchup", calorias: 100.4)]
    
    var itensSelecionados: Array<Item> = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var itensTableView: UITableView?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.adicionarItem))
        
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        
        itens = ItemDao().recuperaDados()
    }
    
    @objc func adicionarItem()
    {
        let AdicionarItemViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(AdicionarItemViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        if let itensTableView = itensTableView
        {
            itensTableView.reloadData()
        }
        else
        {

            Alerta(controller: self).error(title: "Ops!", mensagem: "Algo não foi bem. Tente novamente mais tarde!")
        }
        
    }

    
    // MARK: - IBOutlets
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var felicidadeTextField: UITextField?
    
    // MARK: - IBActions
    @IBAction func adicionar ()
    {
        guard let nome = nomeTextField?.text, let felicidade = felicidadeTextField?.text, let felicidadeNumerica = Int(felicidade)
        else {
            print("Algo nao foi bem...")
            return
            
        }
        
        let refeicao = Refeicao(nome: nome, felicidade: felicidadeNumerica, itens: itensSelecionados)
        
        delegate?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let item = itens[indexPath.row]
        
        celula.textLabel?.text = item.nome
        celula.detailTextLabel?.text = "\(item.calorias) cal"
        
        return celula
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        if celula.accessoryType == .none
        {
            celula.accessoryType = .checkmark
            itensSelecionados.append(itens[indexPath.row])
        }else{
            celula.accessoryType = .none
            let item = itens[indexPath.row]
            if let position = itensSelecionados.firstIndex(of: item)
            {
                itensSelecionados.remove(at: position)
            }
        }
    }

    
}

