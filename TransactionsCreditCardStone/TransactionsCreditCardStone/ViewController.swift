//
//  ViewController.swift
//  TransactionsCreditCardStone
//
//  Created by Jean Carlos on 10/14/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldCVV: UITextField!
    
    
    let name: String = "Jean Carlos"
    let cvv: Int = 737
    let valueTransaction = "R$587,96"
    
    //MARCK: Outlets
    
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfCVV: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textFieldName.placeholder = "Digite o nome igual ao cartão"
        self.textFieldCVV.placeholder = "Digite o código de segurança"
        
        self.textFieldCVV.keyboardType = UIKeyboardType.numberPad
        
        self.textFieldName.delegate = self
        self.textFieldCVV.delegate = self
        
        
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
    
    //Métodos de UITextFielDelegate
    
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
    
    //MARK: Actions

    @IBAction func btnConfirmar(_ sender: UIButton) {
        
        if name == txfName.text && cvv == txfCVV.text.flatMap { Int($0) } {
            
            let alertConfirmation = UIAlertController(title: "Confirmação!", message: "Dados Confirmados com sucesso!", preferredStyle: .alert)
            
            let actionOk = UIAlertAction(title: "OK", style: .default) { (acao) in
                print("Confirmou")
                self.presentSecondAlert()
                self.textFieldName.text = nil
                self.textFieldCVV.text = nil
            }
            
            let actionCancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: { (acao) in
                
                self.textFieldName.text = nil
                self.textFieldCVV.text = nil
                
            })
            
            alertConfirmation.addAction(actionOk)
            alertConfirmation.addAction(actionCancelar)
            
            present(alertConfirmation, animated: true) {
                print("Foi")
            }
        }else{
        
            let alertNotConfirmation : UIAlertController = UIAlertController(title: "Incorreto!", message: "Dados incorretos, favor conferir!", preferredStyle: UIAlertControllerStyle.alert)
            
            let actionOk : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                print("Dados não confirmados")
            })
            
            alertNotConfirmation.addAction(actionOk)
            
            self.present(alertNotConfirmation, animated: true, completion: { 
                print("Não confirmou")
            })
            
        }
        
    }
    

}

