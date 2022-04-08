//
//  BarChartView.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 06.04.2022.
//

import UIKit

class BarChartView: UIView {
        
    private let mainLayer: CALayer = CALayer()
    
    let barWidth: CGFloat = 58.0
    let space: CGFloat = 12.0
    
    private let topSpace: CGFloat = 48.0
    private let bottomSpace: CGFloat = 48.0
    
    private let valueLayerSpace: CGFloat = 4
    private let progressValueLayerSpace: CGFloat = 10
    private let dateSpace: CGFloat = 4
    
    private let valueLayerHeight: CGFloat = 25
    private let progressValueLayerHeight: CGFloat = 25
    private let progressValueLayerWidth: CGFloat = 56
    private let progressValueTextLayerHeight: CGFloat = 17
    private let dateHeight: CGFloat = 25
    
    private var scrollView: UIScrollView = UIScrollView()
    private var labels = [UILabel]()
    
    var dataEntries: [BarChartEntry]? = nil {
        didSet {
            
            mainLayer.sublayers?.forEach({ $0.removeFromSuperlayer() })
            
            if let dataEntries = dataEntries {
                scrollView.contentSize = CGSize(width: (barWidth + space) * CGFloat(dataEntries.count), height: self.frame.size.height)
                
                mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
                
                for i in 0..<dataEntries.count {
                    showEntry(index: i, entry: dataEntries[i])
                }

            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScrollView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureScrollView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = .init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    private func configureScrollView() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
    }
    
    private func showEntry(index: Int, entry: BarChartEntry) {
        let xPos: CGFloat = space + CGFloat(index) * (barWidth + space)
        let yPos: CGFloat = translateHeightValueToYPosition(value: entry.height)
        let yPosValue: CGFloat = yPos - valueLayerSpace - valueLayerHeight
        let yPosDate: CGFloat = mainLayer.frame.height - bottomSpace + dateSpace
        let yProgressValue: CGFloat = yPos - progressValueLayerSpace * 2 - valueLayerHeight - progressValueTextLayerHeight
        
        drawBar(xPos: xPos, yPos: yPos, color: entry.color)
        drawValue(xPos: xPos, yPos: yPosValue, text: entry.value, color: UIColor.white)
        drawDate(xPos: xPos, yPos: yPosDate, text: entry.date, color: UIColor.white)
        drawProgressValue(xPos: xPos, yPos: yProgressValue, text: entry.progressValue, color: UIColor.white, backgroundLayerColor: entry.progressBackgroundColor)
    }
    
    private func drawBar(xPos: CGFloat, yPos: CGFloat, color: UIColor) {
        let barLayer = CALayer()
        barLayer.anchorPoint = CGPoint(x: 1, y: 1)
        barLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth, height: mainLayer.frame.height - bottomSpace - yPos)
        barLayer.backgroundColor = color.cgColor
        barLayer.cornerRadius = 10
        mainLayer.addSublayer(barLayer)
        
        var animations = [CABasicAnimation]()
        
        let barTintAnimation = CABasicAnimation(keyPath: "backgroundColor")
        barTintAnimation.fromValue = barLayer.backgroundColor
        barTintAnimation.toValue = color.cgColor
        barTintAnimation.duration = 1.0
        animations.append(barTintAnimation)
        
        let barHeighttAnimation = CABasicAnimation(keyPath: "bounds.size.height")
        barHeighttAnimation.fromValue = 0
        barHeighttAnimation.toValue = barLayer.bounds.size.height
        barHeighttAnimation.duration = 1.0
        animations.append(barHeighttAnimation)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = animations
        animationGroup.duration = 1.0
        barLayer.add(animationGroup, forKey: nil)
        barLayer.backgroundColor = color.cgColor
    }
    
    private func drawValue(xPos: CGFloat, yPos: CGFloat, text: String, color: UIColor) {
        let valueLayer = drawlayer(xPos: xPos, yPos: yPos, width: barWidth, height: valueLayerHeight, color: color)
        valueLayer.string = text
        mainLayer.addSublayer(valueLayer)
    }
    
    private func drawDate(xPos: CGFloat, yPos: CGFloat, text: String, color: UIColor) {
        let dateLayer = drawlayer(xPos: xPos, yPos: yPos, width: barWidth, height: valueLayerHeight, color: color)
        dateLayer.string = text
        mainLayer.addSublayer(dateLayer)
    }
    
    private func drawlayer(xPos: CGFloat, yPos: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) -> CATextLayer {
        let layer = CATextLayer()
        layer.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        layer.foregroundColor = color.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
        layer.alignmentMode = CATextLayerAlignmentMode.center
        layer.contentsScale = UIScreen.main.scale
        layer.font = UIFont.font(name: .SairaRegular, size: 1)
        layer.fontSize = 16
        return layer
    }
    
    private func drawProgressValue(xPos: CGFloat, yPos: CGFloat, text: String, color: UIColor, backgroundLayerColor: UIColor) {
        if text != "0" {
            let backgroundLayer = CALayer()
            backgroundLayer.frame = CGRect(x: xPos, y: yPos, width: progressValueLayerWidth, height: progressValueLayerHeight)
            backgroundLayer.cornerRadius = 13
            backgroundLayer.masksToBounds = true
            backgroundLayer.backgroundColor = backgroundLayerColor.cgColor
            
            let labelLayer = drawlayer(xPos: xPos, yPos: yPos, width: backgroundLayer.frame.width, height: valueLayerHeight, color: color)
            labelLayer.string = text
            
            mainLayer.addSublayer(backgroundLayer)
            layer.addSublayer(labelLayer)
        }
    }
    
    private func translateHeightValueToYPosition(value: Float) -> CGFloat {
        let height: CGFloat = CGFloat(value) + (mainLayer.frame.height - bottomSpace / 2)
        return mainLayer.frame.height - bottomSpace - height / 2
      }
}
