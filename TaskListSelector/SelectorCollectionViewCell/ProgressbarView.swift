

import Foundation
import UIKit

class ProgressbarView: UIView {
	
	//MARK: Properties
	
	init(frame: CGRect, loadedPercentage: CGFloat?) {
		super.init(frame: frame)
		layer.addSublayer(CAGradientLayer())
		updatePercentage(loadedPercentage: loadedPercentage ?? 0)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func updatePercentage(loadedPercentage: CGFloat) {
		guard let oldLayer = self.layer.sublayers?.first as? CAGradientLayer else {
			return
		}
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = self.bounds
		gradientLayer.colors = [Theme.progressbarColor, UIColor.clear.cgColor]
		if loadedPercentage == 0 || loadedPercentage == 1 {
			// Completely fill progressbar
			gradientLayer.locations = [loadedPercentage, loadedPercentage] as [NSNumber]
		} else {
			// Smoothen transition
			gradientLayer.locations = [max(0, loadedPercentage - 0.15), loadedPercentage] as [NSNumber]
		}
		gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
		gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
		layer.replaceSublayer(oldLayer, with: gradientLayer)
	}
	
}
