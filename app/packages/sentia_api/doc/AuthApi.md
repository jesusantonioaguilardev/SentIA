# sentia_api.api.AuthApi

## Load the API package
```dart
import 'package:sentia_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authForgotPassword**](AuthApi.md#authforgotpassword) | **POST** /v1/auth/password/forgot | 
[**authLogin**](AuthApi.md#authlogin) | **POST** /v1/auth/login | 
[**authLogout**](AuthApi.md#authlogout) | **POST** /v1/auth/logout | 
[**authLogoutAll**](AuthApi.md#authlogoutall) | **POST** /v1/auth/logout-all | 
[**authRefresh**](AuthApi.md#authrefresh) | **POST** /v1/auth/refresh | 
[**authRegister**](AuthApi.md#authregister) | **POST** /v1/auth/register | 
[**authResetPassword**](AuthApi.md#authresetpassword) | **POST** /v1/auth/password/reset | 


# **authForgotPassword**
> authForgotPassword(forgotPasswordDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAuthApi();
final ForgotPasswordDto forgotPasswordDto = ; // ForgotPasswordDto | 

try {
    api.authForgotPassword(forgotPasswordDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authForgotPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **forgotPasswordDto** | [**ForgotPasswordDto**](ForgotPasswordDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authLogin**
> TokenPairDto authLogin(loginDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAuthApi();
final LoginDto loginDto = ; // LoginDto | 

try {
    final response = api.authLogin(loginDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginDto** | [**LoginDto**](LoginDto.md)|  | 

### Return type

[**TokenPairDto**](TokenPairDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authLogout**
> authLogout(refreshDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAuthApi();
final RefreshDto refreshDto = ; // RefreshDto | 

try {
    api.authLogout(refreshDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authLogout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshDto** | [**RefreshDto**](RefreshDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authLogoutAll**
> authLogoutAll()



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAuthApi();

try {
    api.authLogoutAll();
} on DioException catch (e) {
    print('Exception when calling AuthApi->authLogoutAll: $e\n');
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

# **authRefresh**
> TokenPairDto authRefresh(refreshDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAuthApi();
final RefreshDto refreshDto = ; // RefreshDto | 

try {
    final response = api.authRefresh(refreshDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authRefresh: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshDto** | [**RefreshDto**](RefreshDto.md)|  | 

### Return type

[**TokenPairDto**](TokenPairDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRegister**
> TokenPairDto authRegister(registerDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAuthApi();
final RegisterDto registerDto = ; // RegisterDto | 

try {
    final response = api.authRegister(registerDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerDto** | [**RegisterDto**](RegisterDto.md)|  | 

### Return type

[**TokenPairDto**](TokenPairDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authResetPassword**
> authResetPassword(resetPasswordDto)



### Example
```dart
import 'package:sentia_api/api.dart';

final api = SentiaApi().getAuthApi();
final ResetPasswordDto resetPasswordDto = ; // ResetPasswordDto | 

try {
    api.authResetPassword(resetPasswordDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authResetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordDto** | [**ResetPasswordDto**](ResetPasswordDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

