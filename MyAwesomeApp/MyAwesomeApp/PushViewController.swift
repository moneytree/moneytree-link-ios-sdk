//
//  PushViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree KK on 21/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import Dispatch

import MoneytreeLinkCoreKit

class PushViewController: UIViewController {

  @IBOutlet private var pushTokenLabel: UILabel?

  var observation: NSKeyValueObservation?

  override func viewDidLoad() {
    super.viewDidLoad()
    updateUIComponents()

    observation = appDelegate.observe(\.deviceToken) { [weak self] _, _  in
      self?.updateUIComponents()
    }
  }

  @IBAction func sendToServer_() {
    let tokenString = devicePushToken
    guard tokenString != UnregisteredMessage else {
      let alert = UIAlertController(
        title: "UNREGISTERED",
        message: "You should ask permission first.",
        preferredStyle: .alert
      )

      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alert, animated: true)
      return
    }

    guard
      let appDelegate = UIApplication.shared.delegate as? AppDelegate,
      let deviceToken = appDelegate.deviceToken
    else { return }

    let deviceTokenRequest = MTRegisterDeviceTokenAPI(requestBody: deviceToken as NSData) { object, response, error in
      print(
        """
        Response: \(String(describing: object)).
        Response: \(String(describing: response)).
        Error: \(String(describing: error))
        """
      )

      let alert: UIAlertController
      if let error = error {
        let nsError = error as NSError
        alert = UIAlertController(title: "ERROR", message: "\(String(describing: nsError))", preferredStyle: .alert)
      } else {
        alert = UIAlertController(title: "SUCCESS", message: "\(String(describing: object))", preferredStyle: .alert)
      }

      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true)
    }

    MTLinkClient.shared.api?.sendAuthenticatedRequest(deviceTokenRequest)
  }

  @IBAction func deregisterFromServer_() {
    let tokenString = devicePushToken
    guard tokenString != UnregisteredMessage else {
      let alert = UIAlertController(
        title: "UNREGISTERED",
        message: "You should ask permission first.",
        preferredStyle: .alert
      )

      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alert, animated: true)
      return
    }

    guard
      let appDelegate = UIApplication.shared.delegate as? AppDelegate,
      let deviceToken = appDelegate.deviceToken
      else { return }

    let deregisterRequest = MTDeregisterDeviceTokenAPI(requestBody: deviceToken as NSData) { object, response, error in
      print(
        """
        Response: \(String(describing: object)).
        Response: \(String(describing: response)).
        Error: \(String(describing: error))
        """
      )

      let alert: UIAlertController
      if let error = error {
        let nsError = error as NSError
        alert = UIAlertController(title: "ERROR", message: "\(String(describing: nsError))", preferredStyle: .alert)
      } else {
        alert = UIAlertController(title: "SUCCESS", message: "\(String(describing: object))", preferredStyle: .alert)
      }

      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true)
    }

    MTLinkClient.shared.api?.sendAuthenticatedRequest(deregisterRequest)
  }

  @IBAction func enablePush_() {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        print("Granted? \(granted). Error: \(String(describing: error))")
      }
    } else {
      let message = """
                       SDK Supports Push Notificaiton for iOS9,
                       But Sample default implementaion supports supports only for iOS10 and above.
                    """
      let alertController = UIAlertController(
        title: "Push notification demo iOS-9.0",
        message: message,
        preferredStyle: .alert
      )
      alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alertController, animated: true, completion: nil)
    }
  }

  @IBAction func shareButtonPressed_(sender: UIButton) {
    let activityController = UIActivityViewController(
      activityItems: [devicePushToken],
      applicationActivities: nil
    )

    if let popoverPresentationController = activityController.popoverPresentationController {
      popoverPresentationController.sourceView = sender
      popoverPresentationController.sourceRect = sender.frame
    }

    present(activityController, animated: true, completion: nil)
  }

  private func updateUIComponents() {
    pushTokenLabel?.text = devicePushToken
  }

  private var devicePushToken: String {
    guard
      let appDelegate = UIApplication.shared.delegate as? AppDelegate,
      let deviceToken = appDelegate.deviceToken
    else {
      return UnregisteredMessage
    }
    return deviceToken.hexEncodedString
  }

  private var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }

}

private let UnregisteredMessage = "Enable Push Notification\n(Not available in Simulator)"
