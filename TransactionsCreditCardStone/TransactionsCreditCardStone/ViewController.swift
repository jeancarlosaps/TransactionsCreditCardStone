//
//  ViewController.swift
//  TransactionsCreditCardStone
//
//  Created by Jean Carlos on 10/14/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldCVV: UITextField!
    @IBOutlet weak var btnConfirmarIB: UIButton!
    
    
    
    // MARK: Properties
    
    var credCardUserArray = [CredCardUser]()
    
    let name: String = "Jean Carlos"
    let cvv: Int = 737
    let valueTransaction = "R$587,96"
    
    
    // MARK: Função que faz o request da API do apiary.io;
    
    func request() {
        
            Alamofire.request("https://private-949b1-credcarduser.apiary-mock.com/credcarduser").responseJSON { (responseData) -> Void in
                guard let data = responseData.result.value else { return }
                guard let json = data as? [String: Any] else { return }
                
                if let credCardUsersJson = json["credCardUsers"] as? [[String: Any]] {
                    for item in credCardUsersJson {
                        do {
                            let credCardUser = try CredCardUser(json: item)
                            
                            self.credCardUserArray.append(credCardUser!)
                            
                            DispatchQueue.main.async {
                                self.btnConfirmarIB.isEnabled = true
                            }
                        } catch {
                            print(error)
                        }
                    } //for
                    print("Quantidade dentro do array \(self.credCardUserArray.count)")
                    
                }
            }
        
        
//        typealias CredCardUserResponse = [String:Any]
//
//        let credCardUserURLString = "https://private-949b1-credcarduser.apiary-mock.com/credcarduser"
//
//        let session = URLSession.shared
//        (session.dataTask(with: URL(string:credCardUserURLString)!) { [weak self] (data, reponse, error) in
//
//            // Tratamento de erro;
//            guard error == nil else { return }
//
//            do {
//
//                if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? CredCardUserResponse {
//
//                    // O array de repositórios se encontra na chave "itens" do JSON, portanto, precisamos pegá-lo antes;
//                    guard let credCardUserJson = json["credcardUsers"] as? [CredCardUserResponse] else { return }
//
//                    do {
//
//                        self?.credCardUserList = try credCardUserJson.flatMap(CredCardUser.init)
//
//                    } catch let error {
//                        print(error)
//                    }
//
//                } else {
//                    print("Wrong format")
//                }
//
//            } catch let error {
//                print(error)
//            }
//
//        }).resume()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textFieldName.placeholder = "Digite o nome igual ao cartão"
        self.textFieldCVV.placeholder = "Digite o código de segurança"
        
        self.textFieldCVV.keyboardType = UIKeyboardType.numberPad
        
        self.textFieldName.delegate = self
        self.textFieldCVV.delegate = self
        
        request()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentSecondAlert() {
        let alertConfirmationValue = UIAlertController(title: "Valor!", message: "O valor de \(valueTransaction) está correto?", preferredStyle: .alert)
        
        let actionOkConfirmation = UIAlertAction(title: "OK", style: .default) { (acao) in
            print("Confirmou Valor")
        }
        
        let actionCancelConfirmation = UIAlertAction(title: "Cancelar", style: .cancel) { (acao) in
            print("Não confirmou valor")
        }
        
        alertConfirmationValue.addAction(actionOkConfirmation)
        alertConfirmationValue.addAction(actionCancelConfirmation)
        
        present(alertConfirmationValue, animated: true) {
            print("Segundo alerta apresentado")
        }
    }
    
    // Métodos de UITextFielDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.textFieldName) {
            self.textFieldCVV.becomeFirstResponder()
            
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textFieldName.resignFirstResponder()
        self.textFieldCVV.resignFirstResponder()
    }
    
    // MARK: Actions
    
    @IBAction func btnConfirmar(_ sender: UIButton) {
        
        var confirmeData: Bool = false
        for credCardUser in credCardUserArray {

            if credCardUser.nomePortador == self.textFieldName.text && credCardUser.cvv == self.textFieldCVV.text.flatMap { Int($0) } {
                
                func confirmaValor() {
                    
                    let alertConfirmationValue = UIAlertController(title: "Valor!", message: "O valor de R$\(credCardUser.valorTransacao) está correto?", preferredStyle: .alert)
                    
                    let actionOkConfirmation = UIAlertAction(title: "OK", style: .default) { (acao) in
                        print("Confirmou Valor")
                    }
                    
                    let actionCancelConfirmation = UIAlertAction(title: "Cancelar", style: .cancel) { (acao) in
                        print("Não confirmou valor")
                    }
                    
                    alertConfirmationValue.addAction(actionOkConfirmation)
                    alertConfirmationValue.addAction(actionCancelConfirmation)
                    
                    present(alertConfirmationValue, animated: true) {
                        print("Segundo alerta apresentado")
                    }

                }
                
                func saveData() {
                    let defaults = UserDefaults.standard
                    defaults.set(credCardUser.nomePortador, forKey: "nomePortador")
                    defaults.set(credCardUser.numeroCartao, forKey: "numeroCartao")
                    defaults.set(credCardUser.anoVencimento, forKey: "anoVencimento")
                    defaults.set(credCardUser.mesVencimento, forKey: "mesVencimento")
                    defaults.set(credCardUser.bandeira, forKey: "bandeira")
                    defaults.set(credCardUser.cvv, forKey: "cvv")
                    defaults.set(credCardUser.valorTransacao, forKey: "valorTransacao")
                }
                confirmeData = true
                
                let alertConfirmation = UIAlertController(title: "Confirmação!", message: "Dados Confirmados com sucesso!", preferredStyle: .alert)
                
                let actionOk = UIAlertAction(title: "OK", style: .default) { (acao) in
                    print("Confirmou")
                    confirmaValor()
                    saveData()
                    self.textFieldName.text = nil
                    self.textFieldCVV.text = nil
                }
                
                let actionCancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: { (acao) in
                    self.textFieldName.text = nil
                    self.textFieldCVV.text = nil
                })
                
                alertConfirmation.addAction(actionOk)
                alertConfirmation.addAction(actionCancelar)
                
                self.present(alertConfirmation, animated: true) {
                    print("Foi")
                }
                
                break
            }
            
        } // fim do for
        
        if(!confirmeData){
            
            let alertNotConfirmation : UIAlertController = UIAlertController(title: "Incorreto!", message: "Dados incorretos, favor conferir!", preferredStyle: UIAlertControllerStyle.alert)
            
            let actionOk : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                print("Dados não confirmados")
            })
            
            alertNotConfirmation.addAction(actionOk)
            
            self.present(alertNotConfirmation, animated: true, completion: {
                print("Não confirmou")
            })
        }
    } // Fim do action do button.

    

}

