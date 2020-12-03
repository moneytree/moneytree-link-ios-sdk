# Moneytree Link iOS SDK - Project Configuration

The Moneytree Link iOS SDK requires some extra information during runtime, please configure your Xcode project as per instruction below to allow the SDK to operate properly.

### Steps

1. Open your project's Info.plist file
1. Add these two entries: `MoneytreeLinkClientId` and `MoneytreeLinkDevClientId`. Please contact Moneytree team at https://getmoneytree.com/jp/link/contact (Japan) or
https://getmoneytree.com/au/link/contact (Australia) if you don't have the client Ids.
    1. The values are your **Production** and **Development** Client ID respectively as `String`.
    1. The **Development** Client ID is used to connect to the `staging` environment of Moneytree Link, when the SDK is configured in `staging` mode. More details can be found [here](SDKInitialization.md#add-environment-configuration).
    1. The **Production** Client ID is used to connect to the `production` environment of Moneytree Link, when the SDK is configured in `production` mode. More details can be found [here](SDKInitialization.md#add-environment-configuration).
1. Add `URL types` (CFBundleURLTypes) entry **if** it is not there
1. Add the following 2 entries under `URL types` (CFBundleURLTypes) to allow your app to receive Moneytree related deeplink callbacks, one is for **Production** environment and the other one is for **Development**. The URL scheme follows this convention `mtlink<#clientId-short#>`
  1. `mtlink<devevelopment-clientId-short>`. The `devevelopment-clientId-short` is the first 5 characters of your **Development** Client ID.
  1. `mtlink<production-clientId-short>`. The `production-clientId-short` is the first 5 characters of your **Production** Client ID.

### Sample XML

```xml
<key>MoneytreeLinkDevClientId</key>
<string>{your-dev-client-id}</string>
<key>MoneytreeLinkClientId</key>
<string>{your-client-id}</string>
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>mtlink{your-dev-client-id-first-5}</string>
    </array>
  </dict>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>mtlink{your-client-id-first-5}</string>
    </array>
  </dict>
</array>
```