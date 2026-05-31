import Foundation
import BackgroundTasks

class SyncScheduler {
    static let shared = SyncScheduler()
    static let syncTaskIdentifier = "com.rgi.amhisevikari.sync"
    
    private init() {}
    
    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Self.syncTaskIdentifier, using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func schedulePeriodicSync() {
        let request = BGAppRefreshTaskRequest(identifier: Self.syncTaskIdentifier)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 12 * 60 * 60) // 12 hours like Android WorkManager
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    private func handleAppRefresh(task: BGAppRefreshTask) {
        // Schedule the next one
        schedulePeriodicSync()
        
        let operation = Task {
            await Repository.shared.syncData()
        }
        
        task.expirationHandler = {
            operation.cancel()
        }
        
        Task {
            _ = await operation.result
            task.setTaskCompleted(success: true)
        }
    }
}
