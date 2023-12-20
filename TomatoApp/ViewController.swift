import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        //        // Создаем фрейм для slider
        //        let sliderFrame = CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200)
        //
        //        // Создаем экземпляр MSCircularSlider и устанавливаем его свойства
        //        let slider = MSCircularSlider(frame: sliderFrame)
        //        slider.backgroundColor = .white
        //        slider.layer.cornerRadius = 100
        //        slider.clipsToBounds = true
        //        slider.currentValue = 60.0
        //        slider.maximumAngle = 360.0
        //        slider.lineWidth = 10
        //        slider.filledColor = UIColor(red: 127 / 255.0, green: 168 / 255.0, blue: 198 / 255.0, alpha: 1.0)
        //        slider.unfilledColor = .white
        //        slider.handleType = .largeCircle
        //        slider.handleColor = UIColor(red: 127 / 255.0, green: 168 / 255.0, blue: 198 / 255.0, alpha: 1.0)
        //        slider.handleEnlargementPoints = 10
        //        slider.handleHighlightable = false
        //
        //        // Добавляем slider в view
        //        view.addSubview(slider)
        //
        //        // Добавляем UILabel в view и устанавливаем его констрейнты
        //        view.addSubview(label)
        //        label.translatesAutoresizingMaskIntoConstraints = false
        //        NSLayoutConstraint.activate([
        //            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120) // Регулируйте отступ по вертикали
        //        ])
        //
        //        // Устанавливаем слушателя для изменений значения slider
        //        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        //
        //        // Начальное значение для UILabel
        //        label.text = "\(Int(slider.currentValue))"
        //    }
        //
        //    @objc func sliderValueChanged(_ slider: MSCircularSlider) {
        //        label.text = "\(Int(slider.currentValue))"
        //    }
    }
}
