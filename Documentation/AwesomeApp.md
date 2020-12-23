# Using AwesomeApp

***AwesomeApp*** is a reference app created to showcase the SDK's capabilities. It is there to help you understand the SDK's base use cases. Feel free to edit it as you please.

## SDK configuration in the AwesomeApp

First, configure AwesomeApp's `Info.plist` to use your client ID. Please see [Configuring your project](../README.md#configuring-your-project) for details. 

The Moneytree Link SDK is configured in `ViewController.swift`. 

It uses PKCE for authorization by default. You can change `demoMode` to `.authCodeGrant` if you need to test the Code Grant authorization flow.  

You can edit `Constants.configuration` to change other configuration settings to match your use case.

> :information_source: This is **NOT** part of the SDK's spec, just an example of how to implement it in AwesomeApp. You can implement the configuration of the SDK in any way you prefer.

You should now be able to test a sample integration with AwesomeApp.
