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
    func adicionarPokemons(){
        
        
    }
    
    
    //Criar os pokemons
    
    
}
