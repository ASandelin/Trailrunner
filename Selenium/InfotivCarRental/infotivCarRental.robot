*** Settings ***
Resource   user_data_3.0.robot

*** Test Cases ***
BDD-Rent a car
    [Documentation]  Test navigation flow of renting a car and verify booking
    [Tags]  VG_test

    Given User navigate to rental page and logs in with valid credentials   hamid
    When User chooses rental date and rental car
    Then The booking should be succesful

    [Teardown]  Unbook1
Booking function
    [Documentation]  Test sucessful booking
    [Tags]  Booking  ValidInput
    [Setup]  Navigate to page
    Confirm booking with valid input
    [Teardown]  Unbook2
Home Button
    [Documentation]  Test Home function on Succesful booking page
    [Tags]  homeFunctionality
    [Setup]  Navigate to page
    Confirm Home button function
    [Teardown]  Unbook2
My Page Button
    [Documentation]  Test My Page function on Succesful booking page
    [Tags]  myPageFunctionality
    [Setup]  Navigate to page
    Confirm My page button function
    [Teardown]  Unbook2
Page Refresh Error message
    [Documentation]  Verify Error Message by page refresh on Succesful booking page
    [Tags]  FieldValidation  Error
    [Setup]  Navigate to page
    Confirm Refresh Error Message
    [Teardown]  Unbook2

# Create user
#    [Documentation]  Verify user can be created with valid input on Create User page
#    [Tags]  UserCreation  ValidInput
#    [Setup]  Navigate To Create User Page
#    Create user with valid input   ${user10}
Empty firstName Field Alert
    [Documentation]  Verify alert popup appears when firstName field is left empty
    [Tags]  FieldValidation  EmptyField
    [Setup]  Navigate To Create User Page
    ${user_withoutFirstNameInfo}
    [Template]    Userinfo Into Field
    [Teardown]  Confirm Field Alert  ${user_withoutFirstNameInfo}
Empty lastName Field Alert
    [Documentation]  Verify alert popup appears when lasName field is left empty
    [Tags]  FieldValidation  EmptyField
    [Setup]  Navigate To Create User Page
    [Template]    Userinfo Into Field
    ${user_withoutLastNameInfo}
    [Teardown]  Confirm Field Alert  ${user_withoutLastNameInfo}
Empty phone Field Alert
    [Documentation]  Verify alert popup appears when phone field is left empty
    [Tags]  FieldValidation  EmptyField
    [Setup]  Navigate To Create User Page
    [Template]    Userinfo Into Field
    ${user_withoutPhoneInfo}
    [Teardown]  Confirm Field Alert   ${user_withoutPhoneInfo}
Empty Email Field Alert
    [Documentation]  Verify alert popup appears when email field is left empty
    [Tags]  FieldValidation  EmptyField
    [Setup]  Navigate To Create User Page
    [Template]    Userinfo Into Field
    ${user_withoutEmailInfo}
    [Teardown]  Confirm Field Alert   ${user_withoutEmailInfo}
Empty Password Field Alert
    [Documentation]   Verify alert popup appears when password field is left empty
    [Tags]  FieldValidation  EmptyField
    [Setup]  Navigate To Create User Page
    [Template]    Userinfo Into Field
    ${user_withoutPasswordInfo}
    [Teardown]  Confirm Field Alert   ${user_withoutPasswordInfo}
Wrong format Phone field alert
    [Documentation]  Verify alert popup appears when phone field is left empty
    [Tags]  FieldValidation  WrongFormat
    [Setup]  Navigate To Create User Page
    [Template]    Userinfo Into Field
    ${user_withWrongPhoneFormatInfo}
    [Teardown]  Confirm Field Alert   ${user_withWrongPhoneFormatInfo}
Wrong format Email Field alert
    [Documentation]  Verify alert popup appears when email fields is wrong format
    [Tags]  FieldValidation  WrongFormat
    [Setup]  Navigate To Create User Page
    [Template]    Userinfo Into Field
    ${user_withWrongEmailFormatInfo}
    [Teardown]  Confirm Field Alert   ${user_withWrongEmailFormatInfo}
Missmatch input Email Field alert
    [Documentation]   Verify alert popup appears when email fields mismatch
    [Tags]  FieldValidation  Mismatch
    [Setup]  Navigate To Create User Page
    [Template]    Userinfo Into Field
    ${user_withEmailInputMissmatch}
    [Teardown]  Confirm Field Alert   ${user_withEmailInputMissmatch}
Missmatch input Password Field alert
    [Documentation]   Verify alert popup appears when password fields mismatch
    [Tags]  FieldValidation  Mismatch
    [Setup]  Navigate To Create User Page
    Userinfo Into Field  ${user_withPasswordInputMissmatch}
    [Teardown]  Confirm Error Message
Cancel button
    [Documentation]  Test cancel function on Create User page
    [Tags]  CancelFunctionality
    [Setup]  Navigate To Create User Page
    Click Cancel button







