

import Foundation
import UIKit

class MainTask: Task, TaskTableDisplayable {
	
	//MARK: Properties
	var alarm: Alarm?
	
	struct PropertyKeys {
		static let alarm = "alarm"
	}
	
	override init(title: String) {
		super.init(title: title)
	}
	
	init(task: MainTask) {
		super.init(title: task.title)
		alarm = task.alarm
		created = task.created
		id = task.id
		deadline = task.deadline
		done = task.done
		cellHeight = task.cellHeight
	}
	
	func addAlarm(alarm: Alarm) {
		self.alarm = alarm
		AlarmManager.addAlarm(task: self, alarm: alarm)
	}
	
	func removeAlarm() {
		guard alarm != nil else {
			return
		}
		AlarmManager.removeAlarm(id: alarm!.id)
		self.alarm = nil
	}
	
	func resetAlarm() {
		guard let alarm = self.alarm else {
			return
		}
		removeAlarm()
		addAlarm(alarm: alarm)
	}
	
	// If custom alarm has been set, the alarm ID is different from the deadline
	func hasSeperateAlarm() -> Bool {
		guard self.deadline != nil, self.alarm != nil else {
			return false
		}
		return self.deadline!.id != self.alarm!.id
	}
	
	//MARK: NSCoding
	
	override func encode(with aCoder: NSCoder) {
		aCoder.encode(alarm, forKey: PropertyKeys.alarm)
		super.encode(with: aCoder)
	}
	
	required init?(coder aDecoder: NSCoder) {
		self.alarm = aDecoder.decodeObject(forKey: PropertyKeys.alarm) as? Alarm
		super.init(coder: aDecoder)
	}
	
	//MARK: TaskTableDisplayable
	
	func createTaskExtensionView(frame: CGRect) -> TaskTableViewCellContent? {
		return nil
	}
	
	func getTaskExtensionHeight() -> CGFloat {
		return 0
	}
	
}


