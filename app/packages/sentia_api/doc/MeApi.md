# sentia_api.api.MeApi

## Load the API package
```dart
import 'package:sentia_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**meClearEmergencyContact**](MeApi.md#meclearemergencycontact) | **DELETE** /v1/me/emergency-contact | 
[**meExport**](MeApi.md#meexport) | **GET** /v1/me/export | 
[**meGet**](MeApi.md#meget) | **GET** /v1/me | 
[**meRemove**](MeApi.md#meremove) | **DELETE** /v1/me | 
[**meUpdate**](MeApi.md#meupdate) | **PATCH** /v1/me | 


# **meClearEmergencyContact**
> meClearEmergencyContact()



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getMeApi();

try {
    api.meClearEmergencyContact();
} on DioException catch (e) {
    print('Exception when calling MeApi->meClearEmergencyContact: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meExport**
> Map<String, Object> meExport()



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getMeApi();

try {
    final response = api.meExport();
    print(response);
} on DioException catch (e) {
    print('Exception when calling MeApi->meExport: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**Map&lt;String, Object&gt;**

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meGet**
> ProfileDto meGet()



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getMeApi();

try {
    final response = api.meGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling MeApi->meGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ProfileDto**](ProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meRemove**
> meRemove(deleteAccountDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getMeApi();
final DeleteAccountDto deleteAccountDto = ; // DeleteAccountDto | 

try {
    api.meRemove(deleteAccountDto);
} on DioException catch (e) {
    print('Exception when calling MeApi->meRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteAccountDto** | [**DeleteAccountDto**](DeleteAccountDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meUpdate**
> ProfileDto meUpdate(updateProfileDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getMeApi();
final UpdateProfileDto updateProfileDto = ; // UpdateProfileDto | 

try {
    final response = api.meUpdate(updateProfileDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MeApi->meUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateProfileDto** | [**UpdateProfileDto**](UpdateProfileDto.md)|  | 

### Return type

[**ProfileDto**](ProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

