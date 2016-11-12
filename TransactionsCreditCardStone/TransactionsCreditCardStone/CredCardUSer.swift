//
//  CredCardUser.swift
//  TransactionsCreditCardStone
//
//  Created by Jean Carlos on 11/3/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
//

import Foundation

struct CredCardUser {
    
    let nomePortador:String
    let numeroCartao:Int
    let anoVencimento:Int
    let mesVencimento:Int
    let bandeira:String
    let cvv:Int
    let valorTransacao:String
    
}

protocol JSONDecodable {
    
    init?(json: [String: Any]) throws
}

enum SerializationError:Error {
    case missing(String)
}

extension CredCardUser {
    
    public init?(json:[String:Any]) throws {
        
        guard let nomePortador = json["nomePortador"] as? String else {
            throw SerializationError.missing("nomePortador")
        }
        
        guard let numeroCartao = json["numeroCartao"] as? Int else {
            throw SerializationError.missing("numeroCartão")
        }
        
        guard let anoVencimento = json["anoVencimento"] as? Int else {
            throw SerializationError.missing("anoVencimento")
        }
        
        guard let mesVencimento = json["mesVencimento"] as? Int else {
            throw SerializationError.missing("mesVencimento")
        }
        
        guard let bandeira = json["bandeira"] as? String else {
            throw SerializationError.missing("bandeira")
        }
        
        guard let cvv = json["cvv"] as? Int else {
            throw SerializationError.missing("cvv")
        }
        
        guard let valorTransacao = json["valorTransacao"] as? String else {
            throw SerializationError.missing("valorTransacao")
        }
        
        self.nomePortador = nomePortador
        self.numeroCartao = numeroCartao
        self.anoVencimento = anoVencimento
        self.mesVencimento = mesVencimento
        self.bandeira = bandeira
        self.cvv = cvv
        self.valorTransacao = valorTransacao
        
    }
    
    
}
