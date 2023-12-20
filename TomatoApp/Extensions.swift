import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views : [UIView]) -> Void {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
}
extension URL {
    func loadFileFromLocalPath() -> Data? {
        return try? Data(contentsOf: self)
    }
    
    func fileName() -> String {
        return self.deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return self.pathExtension
    }
    
}
extension String{
    
    func toDuration() -> Int{
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "HH:mm:ss"
        isoFormatter.locale = .current
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = isoFormatter.date(from: self) ?? Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
    func containsNumber() -> Bool {
        let capitalLetterRegEx  = ".*[0-9]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: self)
        return capitalresult
    }
    var serverUrlString: String {
        return "\(API.prodURL)/" + self
    }
    var url: URL? {
        return URL(string: self)
    }
    func getDateByString() -> Date{
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        isoFormatter.locale = .current
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = isoFormatter.date(from: self) ?? Date()
        return date
    }
    func getFormatter(_ format: String) -> Date{
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = format
        isoFormatter.locale = .current
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = isoFormatter.date(from: self) ?? Date()
        return date
    }
    func getTimeByString() -> Date {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "HH:mm:ss"
        isoFormatter.locale = .current
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = isoFormatter.date(from: self) ?? Date()
        return date
    }
    func getPhoneSample() -> String{
        if self.count < 12{return ""}
        let noLinePhone = self.replacingOccurrences(of: "-", with: " ")
        var noBracketPhone = noLinePhone.replacingOccurrences(of: " (", with: " ")
        noBracketPhone = noBracketPhone.replacingOccurrences(of: ") ", with: " ")
        let num = String(noBracketPhone.suffix(noBracketPhone.count - 2)).replacingOccurrences(of: " ", with: "")
        return num
    }
    func labelWidth(font: UIFont) -> Int{
        return Int(self.size(withAttributes:[.font: font]).width)
    }
}

extension Int {
    func toString() -> String{
        return "\(self)"
    }
    func getTf() ->String {
        return String(format: "%02d", self)
    }
    func toDuration() -> String {
        let h = self.getTf()
        let duration = "\(h):00:00"
        return duration
    }
}

extension UIStackView {
    @discardableResult func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
}
extension UIButton {
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.titleLabel?.text! ?? ""
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.titleLabel?.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.titleLabel?.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.setAttributedTitle(answerAttributed, for: .normal)
    }
    
    var vissibleTextLength: Int {
        let font: UIFont = self.titleLabel?.font ?? .systemFont(ofSize: 16)
        let mode: NSLineBreakMode = (self.titleLabel?.lineBreakMode) ?? .byCharWrapping
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.titleLabel?.text ?? "", attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        guard let text = self.titleLabel?.text else {return 0 }
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (text as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: text.count - index - 1)).location
                }
            } while index != NSNotFound && index < text.count && (text as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return text.count
    }
}

extension UICollectionView {
    func registerCell(types cells: UICollectionViewCell.Type...) {
        for cell in cells {
            self.register(cell.self, forCellWithReuseIdentifier: cell.cellId)
        }
    }
    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                                  for: indexPath) as? T else {
            fatalError("Couldn't find nib file for \(String(describing: T.self))")
        }
        return cell
    }
}
extension Date {
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let resultString = dateFormatter.string(from: self)
        return resultString
    }
    var dateString1: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let resultString = dateFormatter.string(from: self)
        return resultString
    }
    var dateString2: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let resultString = dateFormatter.string(from: self)
        return resultString
    }
    func difference(_ otherDate: Date) -> TimeInterval{
        let diffSeconds = self.timeIntervalSinceReferenceDate - otherDate.timeIntervalSinceReferenceDate
        return diffSeconds
    }
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    func getFormatter(_ format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    func getDateFormatters(_ formats : String...) -> [String] {
        var dates: [String] = []
        for format in formats {
            dates.append(self.getFormatter(format))
        }
        return dates
    }
    func getWeekDates() -> (thisWeek:[Date],nextWeek:[Date]) {
        var tuple: (thisWeek:[Date],nextWeek:[Date])
        var arrThisWeek: [Date] = []
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!)
        }
        var arrNextWeek: [Date] = []
        for i in 1...7 {
            arrNextWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrThisWeek.last!)!)
        }
        tuple = (thisWeek: arrThisWeek,nextWeek: arrNextWeek)
        return tuple
    }
    var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
