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
    //Atributo para utilizar os recursos do coredata Pokemon
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        //O Objeto vai ser gerenciado pela própria classe viewController.
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        //recuperar pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosPokemons()
        
        //Criar uma exibição de mensagens aleatórias para depois trocar por imagens de pokémons.
        
        //Utilizar a classe timer, para criar as mensagens programadas.
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
           //teste do timer.
            print("exibe anotação")
            
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate {
                //Criada constante para gerar números aleatórios e utilizar os números para selecionar os nomes dos pokemons aleatoriamente, pois no método, mkannotation, não possui outro parâmetro que pudesse gerar imagens aleatórias.
                let totalPokemons = UInt32( self.pokemons.count)
                let indicePokemonAleatorio = arc4random_uniform(totalPokemons)
                
                let pokemon = self.pokemons[ Int(indicePokemonAleatorio) ]
                //print para testar se está selecionando aleatoriamente os nomes dos pokemons.
                print( pokemon.nome )
                
                //alterado de mkpointanotation, para a classe pokemonAnotacao
                    let anotacao = PokemonAnotacao(coordenadas: coordenadas, pokemon: pokemon)
                
                //Constantes para irem gerando latitude e longitudes aleatórias positivas e negativas
                let latAleatoria = (Double (arc4random_uniform(400)) - 200 ) / 100000.0
                let longAleatoria = (Double (arc4random_uniform(400)) - 200 ) / 100000.0
                
                
                //não precisa mais, pois foi criada a classe pokemonAnotacao que já possui essa configuracao
                //anotacao.coordinate = coordenadas
                anotacao.coordinate.latitude += latAleatoria
                anotacao.coordinate.longitude += longAleatoria
                    
                self.mapa.addAnnotation( anotacao )
                 
            }
            
        }
        
        
    }
    //Método que recupera as anotações geradas no mapa e trata, trocando por imagens.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil )
        
        let imagePikachu: UIImage = UIImage.init(named: "pikachu-2")!
        let imagePlayer: UIImage = UIImage.init(named: "player")!
        
        if annotation is MKUserLocation{//player
            
            anotacaoView.image = imagePlayer
            
        }else{//Mensagens aleatórias
            //constante anot. criada para atribuir ao annotation, neste caso agora receber além do anatocao o objeto aleatorio de nomes (pokemon)
            let pokemon = (annotation as! PokemonAnotacao).pokemon
            //print( anot.pokemon.nome )
            anotacaoView.image = UIImage(named: pokemon.nomeImagem!)
        }
        
        return anotacaoView
        
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

