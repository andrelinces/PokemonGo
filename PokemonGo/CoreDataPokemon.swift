//
//  CoreDataPokemon.swift
//  PokemonGo
//
//  Created by Andre Linces on 16/09/21.
//

import UIKit
import CoreData

class CoreDataPokemon {
    
    //Recuperar os contextos
    func getContex() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }
    
    
    //Adicionar todos os pokemons
    func adicionarTodosPokemons(){
        
        let context = self.getContex()
        
    
        self.criarPokemon(nome: "Mew", nomeImage: "mew", capturado: false)
        self.criarPokemon(nome: "Caterpie", nomeImage: "caterpie", capturado: false)
        self.criarPokemon(nome: "Charmander", nomeImage: "charmander", capturado: false)
        self.criarPokemon(nome: "Pikachu", nomeImage: "pikachu-2", capturado: true)
        //self.criarPokemon(nome: "Mew", nomeImage: "mew", capturado: false)
        
        do {
            try context.save()
        } catch  {
            
        }
        
        
    }
    
    
    //Criar os pokemons
    func criarPokemon( nome: String, nomeImage: String, capturado: Bool ){
        
        let context = self.getContex()
        let pokemon = Pokemon.init(context: context)
        pokemon.nome = nome
        pokemon.nomeImagem = nomeImage
        pokemon.capturado = capturado
        
    }
    
    //Método para recuperar os pokémons, testando antes se já exite os pokémons criados senão adiciona-los uma única vez
    func recuperarTodosPokemons() -> [Pokemon] {
        
        let context = self.getContex()
        
        
        do {
            let pokemons = try context.fetch( Pokemon.fetchRequest() ) as! [Pokemon]
            //teste para verificar se tem pokemons adicionado, senão inicializa a adição.
            if pokemons.count == 0 {
                
                self.adicionarTodosPokemons()
                
                return self.recuperarTodosPokemons()
            }
            
            return pokemons
            
        } catch  {
            
        }
        return []
        
    }
    
    func recuperarPokemonsCapturado( capturado: Bool ) -> [Pokemon] {
        
        let context = self.getContex()
        //configurando requisicao
        let requisicao = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        requisicao.predicate = NSPredicate(format: "capturado = %@", NSNumber(booleanLiteral: capturado) )
        
        do {
            let pokemons =  try context.fetch( requisicao )
            return pokemons
        } catch  {
            
        }
        
        return []
    }
    
}
