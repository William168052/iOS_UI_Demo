//
//  SiriWaveView.swift
//  SiriWaveView
//
//  Created by William on 2018/4/26.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class SiriWaveView: UIView {
    
    //wave的layer
    private lazy var waveShapeLayer : CAShapeLayer? = {
       return CAShapeLayer.init()
    }()
    
    //计时器
    private lazy var displayLink : CADisplayLink? = {
        let displayLink = CADisplayLink.init(target: self, selector: #selector(waveFlow))
        return displayLink
    }()
    //计时器selector方法
    @objc private func waveFlow() {
        phase = phase! - rate!
        self.setNeedsDisplay()
    }
    
    var waveEdgeInset : UIEdgeInsets? = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    
    //相位
    var phase : Float? = 0

    //速率
    var rate : Float? = 0.1
    
    //一个周期内最大起伏数量(0-1)
    var maxFrequency : Float? = 0.45
    
    //一个周期内最大起伏数量(0-1)
    var minFrequency : Float? = 0.1
    
    //波浪数目
    var waveNumber : Int! = 3
    
    //波浪最大高度(0-1)
    var maxAmplitude : Float? = 0.1
    
    //描边线条宽度(建议0-1)
    var waveWidth : Float? = 0.5
    
    
    //描边颜色
    var strokeColor : UIColor? = UIColor.red
    
    //填充颜色
    var fillColor : UIColor? = UIColor.clear
    
    
    
    
    //更新波形
    func updateWaveSettings(){
        
    }

    
    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let lineWidth = self.waveWidth!
        
        //创建一个path
//        let path = CGMutablePath.init()
        
        for numIdx in 1...waveNumber {
            //保存原始状态到图形上下文栈
            ctx?.saveGState()
            //设置线条宽度
//            self.waveShapeLayer?.lineWidth = CGFloat(self.waveWidth! / Float(numIdx))
            
            
            //设置描边颜色及其透明度
            let strokeAlpha = CGFloat(1 / sqrt(Float(waveNumber - numIdx + 1)))
            self.strokeColor?.withAlphaComponent(strokeAlpha).setStroke()
//            self.waveShapeLayer?.strokeColor = self.strokeColor!.cgColor
            //设置填充颜色
            self.fillColor?.setFill()
//            self.waveShapeLayer?.fillColor = self.fillColor!.cgColor
            //设置线条粗细
            ctx?.setLineWidth(CGFloat(sqrt(lineWidth) * Float(numIdx)))

            
            //设置wave高度
            let halfHeight = frame.height / 2;
            //设置最高波形高度
            let maxA = Float(halfHeight) * maxAmplitude!
            //设置最低波形高度
            let idleAmplitude : Float = Float(maxA / 3)
            
            //设置当前波中的波浪起伏数量
            let curFrequency : Float = maxFrequency! * Float(((maxFrequency! - minFrequency!) / Float(waveNumber)) * Float(numIdx))
            
            //当前波形振幅
            let curAmplitude = max(maxA * (Float(numIdx) / Float(waveNumber!)),idleAmplitude)
            

            //设置wave的偏移距离
            let offsetY = (Float)(self.bounds.size.height / 2)
            var Y = offsetY
            for i in Int((self.waveEdgeInset?.left)!)...(Int)(self.bounds.width - (self.waveEdgeInset?.right)!) {

                Y = curAmplitude * sin(Float.pi / Float(self.bounds.width) * Float(i)) * sin(curFrequency / 10 * (Float)(i) + phase!) + offsetY

                
                if i == Int((self.waveEdgeInset?.left)!) {
//                    path.move(to: CGPoint.init(x: CGFloat(i), y:(CGFloat)(Y)))
                    ctx!.move(to: CGPoint.init(x: CGFloat(i), y:(CGFloat)(Y)))
                }
                
//                path.addLine(to: CGPoint.init(x: (CGFloat)(i), y: (CGFloat)(Y)))
                ctx!.addLine(to: CGPoint.init(x: (CGFloat)(i), y: (CGFloat)(Y)))
                //            print("i : \(i)-------y : \(Y)")
            }
            
            ctx?.strokePath()
        }
        
        
        //从图形上下文栈恢复原始状态
        ctx?.restoreGState()
        
//        self.waveShapeLayer?.path = path;
        
        
//        self.layer.addSublayer(self.waveShapeLayer!)
        
        
    }
    
    func wavePlay() {
        self.displayLink?.add(to: RunLoop.current, forMode: .commonModes)
    }


}
