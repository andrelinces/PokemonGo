//
//  PokemonAnotacao.swift
//  PokemonGo
//
//  Created by Andre Linces on 17/09/21.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    //atributo pokemon customizado, na classe viewController para receber os nomes aleatórios dos pokemons
    var pokemon: Pokemon
    
    init( coordenadas: CLLocationCoordinate2D, pokemon: Pokemon ) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
    
}
