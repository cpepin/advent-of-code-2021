import Foundation

public class Utils {
    public static func parseInput(inputUrl: String) -> [Substring] {
        do {
            if let inputUrl = Bundle.main.url(forResource: inputUrl, withExtension: "txt") {
                let inputString = try String(contentsOf: inputUrl)
                return inputString.split{ $0.isNewline }
            } else {
                preconditionFailure("Cannot find input file")
            }
        } catch {
            preconditionFailure("Error loading contents of input file: \(error)")
        }
    }
}
