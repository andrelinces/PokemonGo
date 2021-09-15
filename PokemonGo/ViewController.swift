//
//  ViewController.swift
//  PokemonGo
//
//  Created by Andre Linces on 15/09/21.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {


    @IBOutlet weak var mapa: MKMapView!
    
    var gerenciadorLocalizacao = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        //O Objeto vai ser gerenciado pela própria classe viewController.
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }
    //Método para verificar quando usuário nega permissão de acesso a localização.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse && status != .notDetermined{
            
            //Alerta
            let alertController = UIAlertController(title: "Permissão de localização !",
                                                    message: "Para que você possa caçar pokemons, precisamos da sua localização, por favor, Habilite",
                                                    preferredStyle: .alert)
            
            let acaoConfiguracoes = UIAlertAction(title: "Acessar Configurações?", style: .default) { (alertaConfiguracoes) in
                
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString){
                    
                    UIApplication.shared.open(configuracoes as URL )
                    
                }
             
            }
            
            let acaoCancelar = UIAlertAction(title: "Cancelar ?", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
        }
        
    }

}

