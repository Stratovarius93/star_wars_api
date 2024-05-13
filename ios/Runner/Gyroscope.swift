//
//  Gyroscope.swift
//  Runner
//
//  Created by Juan Carlos Catagña Tipantuña on 12/5/24.
//

import CoreMotion
import Foundation

class Gyroscope {
    static let instance = Gyroscope()
    private let motionManager = CMMotionManager()
    private var methodChannel: FlutterMethodChannel?

    private init() {}

    func startListening() {
        guard let controller = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController else {
            return
        }
        methodChannel = FlutterMethodChannel(name: "gyroscope_channel", binaryMessenger: controller.binaryMessenger)

        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: OperationQueue.current!) { [weak self] gyroData, error in
                guard let gyroData = gyroData, error == nil else { return }
                let gyroX = gyroData.rotationRate.x
                let gyroY = gyroData.rotationRate.y
                self?.sendGyroscopeValues(x: gyroX, y: gyroY)
            }
        }
    }

    private func sendGyroscopeValues(x: Double, y: Double) {
        methodChannel?.invokeMethod("updateGyroscopeValues", arguments: ["x": x, "y": y])
    }
}
