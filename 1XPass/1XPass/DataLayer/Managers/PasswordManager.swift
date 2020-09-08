
import Foundation

//MARK: Enumeration

enum PasswordContent: Int {
    case number
    case specialSymbol
    case literal
    
    var value: String {
        switch self {
        case .number:
            return "1234567890"
        case .specialSymbol:
            return "#$%&'()*+,-./:;<=>_`{|}~"
        case .literal:
            return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
    }
}

enum PasswordStyle: Int  {
    case apple
    case pinUp
    case token
    
    var value: String {
        switch self {
        case .apple:
            return "Apple"
        case .pinUp:
            return "1XPass"
        case .token:
            return "Token"
        }
    }
}


class PasswordManager {
    
    // MARK: - Properties
    
    var passwordContents = Set<PasswordContent>()
    var passwordStyle: PasswordStyle?
    var length: Int? = 16
    var passwordName: String?
    var defaultText = "Your new password will be here"
    
    // MARK: - Methods
    
    func generatePassword() -> String {
        
        var sourceCharachter = ""
        var password = ""
        
        passwordContents.forEach { (passwordContent) in
            sourceCharachter += passwordContent.value
        }
        
        if !passwordContents.isEmpty  {
            password = String((0..<length!).map{ _ in sourceCharachter.randomElement()! })
        }
        
        guard let passwordStyle = passwordStyle, password != "" else { return defaultText  }
        
        return passwordStyle.value + "_" + password
    }
}
