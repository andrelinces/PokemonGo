//
//  PokemonAgendaViewController.swift
//  PokemonGo
//
//  Created by Andre Linces on 17/09/21.
//

import UIKit

class PokemonAgendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recupera o array dos pokemons, recebendo o atributo capturado.(configurado no método recuperarPokemonsCapturado)
        let coreDataPokemon = CoreDataPokemon()
        
        self.pokemonsCapturados = coreDataPokemon.recuperarPokemonsCapturado(capturado: true)
        self.pokemonsNaoCapturados = coreDataPokemon.recuperarPokemonsCapturado(capturado: false)
  
        print( String(self.pokemonsNaoCapturados.count) )
        
    }
    //Quantidade de sessões por célula, aprendendo retornar mais de 1 item.
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    //Método para tratar as sessões definidas no numberofsections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            
            return "Capturados"
            
        }else{
            
            return "Não Capturados"
        }
        
    }
    //Método para exibir(retornar) a quantidade de linas por célula(sessões)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return self.pokemonsCapturados.count
            
        }else{
            
            return self.pokemonsNaoCapturados.count
            
        }
        
    }
    //Método para montar a célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: "celulaReuso")
        celula.textLabel?.text = "texto"
        
        return celula
        
    }
    
    @IBAction func voltarMapa(_ sender: Any) {
        //Método que irá tratar quando o usuário clicar no pokeagenda.
        dismiss(animated: true, completion: nil)
        
    }
    
}
