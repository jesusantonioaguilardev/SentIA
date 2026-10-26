# sentia_api.api.SafetyApi

## Load the API package
```dart
import 'package:sentia_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**safetyResources**](SafetyApi.md#safetyresources) | **GET** /v1/safety/resources | 


# **safetyResources**
> List<SafetyResourceDto> safetyResources(country)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getSafetyApi();
final String country = MX; // String | 

try {
    final response = api.safetyResources(country);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SafetyApi->safetyResources: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **country** | **String**|  | [optional] 

### Return type

[**List&lt;SafetyResourceDto&gt;**](SafetyResourceDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

