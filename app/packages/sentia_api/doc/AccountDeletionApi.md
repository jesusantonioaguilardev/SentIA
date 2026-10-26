# sentia_api.api.AccountDeletionApi

## Load the API package
```dart
import 'package:sentia_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountDeletionConfirm**](AccountDeletionApi.md#accountdeletionconfirm) | **POST** /v1/account-deletion-requests/confirm | 
[**accountDeletionRequest**](AccountDeletionApi.md#accountdeletionrequest) | **POST** /v1/account-deletion-requests | 


# **accountDeletionConfirm**
> accountDeletionConfirm(confirmDeletionDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAccountDeletionApi();
final ConfirmDeletionDto confirmDeletionDto = ; // ConfirmDeletionDto | 

try {
    api.accountDeletionConfirm(confirmDeletionDto);
} on DioException catch (e) {
    print('Exception when calling AccountDeletionApi->accountDeletionConfirm: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **confirmDeletionDto** | [**ConfirmDeletionDto**](ConfirmDeletionDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountDeletionRequest**
> accountDeletionRequest(accountDeletionRequestDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAccountDeletionApi();
final AccountDeletionRequestDto accountDeletionRequestDto = ; // AccountDeletionRequestDto | 

try {
    api.accountDeletionRequest(accountDeletionRequestDto);
} on DioException catch (e) {
    print('Exception when calling AccountDeletionApi->accountDeletionRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountDeletionRequestDto** | [**AccountDeletionRequestDto**](AccountDeletionRequestDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

