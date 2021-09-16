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
    //Para estipular a quantidade de vezes que o método didupadate será executado automaticamente, para depois para de executar e usuário conseguir mover o mapa sem centralizar automaticamente.
    var contador = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        //O Objeto vai ser gerenciado pela própria classe viewController.
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        //Criar uma exibição de mensagens aleatórias para depois trocar por imagens de pokémons.
        
        //Utilizar a classe timer, para criar as mensagens programadas.
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
           //teste do timer.
            print("exibe anotação")
            
        }
        
        
    }
    
    //Método para localizar o usuário no mapa.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //centralizar o jogador
        
        
        /*
        if let cordenadas = gerenciadorLocalizacao.location?.coordinate{
            
            //Configurando o mapa.
            
            //let latitude: CLLocation = cordenadas
            //let longitude: CLLocation = cordenadas
            
            //let localizacao = CLLocationCoordinate2DMake(latitude, longitude)
            
            //let span = MKCoordinateSpan(latitudeDelta: <#T##CLLocationDegrees#>, longitudeDelta: <#T##CLLocationDegrees#>)
         */
         
            if contador < 3 {
                
                centralizar()
                
                contador += 1
                //print para testar o contador
                print("Executou... contator")
            }else{
                
                gerenciadorLocalizacao.stopUpdatingLocation()
                //print para verificar se entrou no else e parou o didupdate
                print("Executou... parou didupdate")
             
        }
        
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
            
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    func centralizar (){
        
        if let cordenadas = gerenciadorLocalizacao.location?.coordinate{
        let regiao = MKCoordinateRegion.init(center: cordenadas,latitudinalMeters: 200, longitudinalMeters: 200)
        
        mapa.setRegion(regiao, animated: true)
        
        contador += 1
        }
        
    }
    //Botão compass para centralizar o jogador no mapa.
    @IBAction func centralizarJogador(_ sender: Any) {
        
        centralizar()
        
    }
    //Abrir pokedex.
    @IBAction func abrirPokedex(_ sender: Any) {
    }
    
}

