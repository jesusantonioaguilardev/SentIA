# sentia_api.api.ConsentsApi

## Load the API package
```dart
import 'package:sentia_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**consentCurrent**](ConsentsApi.md#consentcurrent) | **GET** /v1/consents/current | 
[**consentMine**](ConsentsApi.md#consentmine) | **GET** /v1/me/consents | 
[**consentRecord**](ConsentsApi.md#consentrecord) | **POST** /v1/consents | 


# **consentCurrent**
> List<ConsentDocumentDto> consentCurrent()



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getConsentsApi();

try {
    final response = api.consentCurrent();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ConsentsApi->consentCurrent: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;ConsentDocumentDto&gt;**](ConsentDocumentDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **consentMine**
> List<ConsentStatusDto> consentMine()



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getConsentsApi();

try {
    final response = api.consentMine();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ConsentsApi->consentMine: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;ConsentStatusDto&gt;**](ConsentStatusDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **consentRecord**
> consentRecord(recordConsentDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getConsentsApi();
final RecordConsentDto recordConsentDto = ; // RecordConsentDto | 

try {
    api.consentRecord(recordConsentDto);
} on DioException catch (e) {
    print('Exception when calling ConsentsApi->consentRecord: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recordConsentDto** | [**RecordConsentDto**](RecordConsentDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

