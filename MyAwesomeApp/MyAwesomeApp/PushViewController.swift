//
//  PushViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree KK on 21/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

import UIKit
import UserNotifications

import MoneytreeLinkCoreKit

class PushViewController: UIViewController {

  @IBOutlet private weak var pushTokenLabel: UILabel!

  private var appDelegate: AppDelegate {
    UIApplication.shared.delegate as! AppDelegate
  }

  private var devicePushToken: Data? {
    appDelegate.deviceToken
  }

  private var observation: NSKeyValueObservation?

  override func viewDidLoad() {
    super.viewDidLoad()
    updateUIComponents()

    observation = appDelegate.observe(\.deviceToken) { [weak self] _, _  in
      DispatchQueue.main.async {
        self?.updateUIComponents()
      }
    }
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    observation = nil
  }

  @IBAction func sendToServer_() {
    guard let token = devicePushToken else {
      let alert = UIAlertController(
        title: "No token is available",
        message: "SDK should obtain a device token first.",
        preferredStyle: .alert
      )
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alert, animated: true)
      return
    }

    let deviceTokenRequest = MTRegisterDeviceTokenAPI(
      requestBody: token as NSData
    ) { [weak self] object, response, error in
      print(
        """
        Response: \(String(describing: object)).
        Response: \(String(describing: response)).
        Error: \(String(describing: error))
        """
      )

      let alert: UIAlertController
      if let error = error {
        alert = UIAlertController(title: "ERROR", message: "\(String(describing: error))", preferredStyle: .alert)
      } else {
        alert = UIAlertController(title: "SUCCESS", message: "\(String(describing: object))", preferredStyle: .alert)
      }
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      DispatchQueue.main.async {
        self?.present(alert, animated: true)
      }
    }
    MTLinkClient.shared.api?.sendAuthenticatedRequest(deviceTokenRequest)
  }

  @IBAction func deregisterFromServer_() {
    guard let token = devicePushToken else {
      let alert = UIAlertController(
        title: "No token is available",
        message: "SDK should obtain a device token first.",
        preferredStyle: .alert
      )
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alert, animated: true)
      return
    }

    let deregisterRequest = MTDeregisterDeviceTokenAPI(
      requestBody: token as NSData
    ) { [weak self] object, response, error in
      print(
        """
        Response: \(String(describing: object)).
        Response: \(String(describing: response)).
        Error: \(String(describing: error))
        """
      )
      let alert: UIAlertController
      if let error = error {
        alert = UIAlertController(title: "ERROR", message: "\(String(describing: error))", preferredStyle: .alert)
      } else {
        alert = UIAlertController(title: "SUCCESS", message: "\(String(describing: object))", preferredStyle: .alert)
      }
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      DispatchQueue.main.async {
        self?.present(alert, animated: true)
      }
    }
    MTLinkClient.shared.api?.sendAuthenticatedRequest(deregisterRequest)
  }

  @IBAction func enablePush_() {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound]
      ) { granted, error in
        print("Granted?: \(granted), Error?: \(String(describing: error))")
      }
    } else {
      let alertController = UIAlertController(
        title: "AwesomeApp doesn't support Push Notification for iOS 9",
        message: """
                  SDK supports Push Notificaiton for iOS 9,
                  However sample implementation supports only iOS 10 and above.
                 """,
        preferredStyle: .alert
      )
      alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alertController, animated: true, completion: nil)
    }
  }

  @IBAction func shareButtonPressed_(sender: UIButton) {
    guard let token = devicePushToken else {
      let alertController = UIAlertController(
        title: "No token is available",
        message: "No sharable contents.",
        preferredStyle: .alert
      )
      alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alertController, animated: true, completion: nil)
      return
    }
    let activityController = UIActivityViewController(
      activityItems: [token.hexEncodedString],
      applicationActivities: nil
    )
    if let popoverPresentationController = activityController.popoverPresentationController {
      popoverPresentationController.sourceView = sender
      popoverPresentationController.sourceRect = sender.frame
    }
    present(activityController, animated: true, completion: nil)
  }

  private func updateUIComponents() {
    pushTokenLabel.text = devicePushToken?.hexEncodedString
  }
}
