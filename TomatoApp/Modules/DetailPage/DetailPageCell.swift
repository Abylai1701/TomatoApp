import UIKit
import SnapKit

class DetailPageCell: UITableViewCell {
    
    private var timer: Timer?
    private var elapsedTime: TimeInterval = 0
    private var isTimerRunning: Bool = false
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .greenColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.textColor = .black
        label.text = "Focus time"
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private lazy var cycleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.textColor = .black
        label.text = "1/5 cycle"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 24)
        label.textColor = .black
        label.text = "25 min"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    private lazy var circularSlider: MSCircularSlider = {
        let slider = MSCircularSlider(frame: frame)
        slider.currentValue = 0
        slider.maximumAngle = 360.0
        slider.filledColor = .black
        slider.unfilledColor = .white
        slider.handleType = .smallCircle
        slider.handleColor = UIColor(red: 35 / 255.0, green: 69 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        slider.handleEnlargementPoints = 12
        slider.isUserInteractionEnabled = false
        return slider
    }()
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.text = formattedTime(elapsedTime)
        return label
    }()
    private lazy var whiteBack: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "white_back")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var pauseView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pause")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pauseViewTapped))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    private lazy var nextView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "next")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func resetTimer() {
        timer?.invalidate()
        elapsedTime = 0
        isTimerRunning = false
        startTimer()
    }
    
    @objc private func updateTimer() {
        guard elapsedTime > 0 else {
            timer?.invalidate()
            // Добавьте сюда код, который нужно выполнить, когда таймер достигнет нуля
            return
        }
        
        elapsedTime -= 1
        timerLabel.text = formattedTime(elapsedTime)
        
        let increment: Double = 0.3333
        var sliderValue = circularSlider.currentValue
        print(sliderValue)
        if sliderValue < 360 {
            sliderValue += increment
            circularSlider.currentValue = sliderValue
        }
    }


        
    private func formattedTime(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: timeInterval) ?? "25:00"
    }
    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(mainView)
        mainView.addSubviews(typeLabel,
                             cycleLabel,
                             timeLabel,
                             circularSlider,
                             timerLabel,
                             whiteBack,
                             pauseView,
                             nextView)
        let initialTime: TimeInterval = 5 * 60
        elapsedTime = initialTime
        timerLabel.text = formattedTime(initialTime)
    }
    @objc private func pauseViewTapped() {
        if isTimerRunning {
            timer?.invalidate()
        } else {
            startTimer()
        }
        isTimerRunning.toggle()
    }
    
    // Метод для остановки таймера
    private func pauseTimer() {
        timer?.invalidate()
        isTimerRunning = false
    }
    private func setupConstraints() {
        
        timeLabel.isHidden = false
        circularSlider.isHidden = true
        
        mainView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(100)
        }
        typeLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(16)
        }
        cycleLabel.snp.remakeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(1)
            make.leading.equalToSuperview().offset(16)
        }
        timeLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-18)
            make.width.equalTo(50)
        }
        layoutIfNeeded()
    }
    
    private func animConstraints() {
        
        timeLabel.isHidden = true
        circularSlider.isHidden = false
        timerLabel.isHidden = false
        whiteBack.isHidden = false
        pauseView.isHidden = false
        nextView.isHidden = false

        mainView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(300)
        }
        cycleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-18)
        }
        circularSlider.snp.remakeConstraints { make in
            make.top.equalTo(cycleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(135)
        }
        timerLabel.snp.remakeConstraints { make in
            make.center.equalTo(circularSlider.snp.center)
        }
        whiteBack.snp.remakeConstraints { make in
            make.top.equalTo(circularSlider.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
        pauseView.snp.remakeConstraints { make in
            make.center.equalTo(whiteBack.snp.center)
        }
        nextView.snp.remakeConstraints { make in
            make.left.equalTo(whiteBack.snp.right).offset(10)
            make.centerY.equalTo(whiteBack.snp.centerY)
        }
        layoutIfNeeded()
    }
    
    
    func updateCellAppearance(isSelected: Bool) {
        if isSelected {
            animConstraints()
        } else {
            setupConstraints()
        }
    }
    
}
