*** Settings ***
Library    SeleniumLibrary
Library    DateTime

*** Variables ***
${URL}          http://rental7.infotiv.net/

# Create User Data and login data
&{user1}     firstName=John   lastName=Doe        phoneNumber=0000000000    email=foo1@mail.com           password=123456
&{user2}     firstName=Jane   lastName=Doe        phoneNumber=1111111111    email=jane@mail.com           password=123456
&{user3}     firstName=Bob    lastName=Johnson    phoneNumber=2222222222    email=bob.johnson@mail.com    password=123abc
&{user4}     firstName=Rob    lastName=Jonsson    phoneNumber=3333333333    email=rob.jonsson@mail.com    password=123abc
&{user5}     firstName=Tob    lastName=Honsson    phoneNumber=4444444444    email=tob.honsson@mail.com    password=123abc
&{user6}     firstName=Pob    lastName=Gonsson    phoneNumber=5555555555    email=pob.gonsson@mail.com    password=123abc
&{user7}     firstName=Cob    lastName=Consson    phoneNumber=6666666666    email=cob.consson@mail.com    password=123abc
&{user8}     firstName=Mob    lastName=Monsson    phoneNumber=7777777777    email=mob.monsson@mail.com    password=123abc
&{user9}     firstName=Aob    lastName=Aonsson    phoneNumber=8888888888    email=aob.aonsson@mail.com    password=123abc
&{user10}    firstName=Eob    lastName=Eonsson    phoneNumber=9999999999    email=eob.eonsson@mail.com    password=123abc

# Field Validation Data
&{user_withoutFirstNameInfo}      field_id=name            firstName=      lastName=Doe  phoneNumber=2222222222  email=foo3@mail.com         password=123abc      field_status=False  field_message=Please fill out this field.
&{user_withoutLastNameInfo}       field_id=last            firstName=John  lastName=     phoneNumber=2222222222  email=foo3@mail.com         password=123abc      field_status=False  field_message=Please fill out this field.
&{user_withoutPhoneInfo}          field_id=phone           firstName=John  lastName=Doe  phoneNumber=            email=foo3@mail.com         password=123abc      field_status=False  field_message=Please fill out this field.
&{user_withoutEmailInfo}          field_id=emailCreate     firstName=John  lastName=Doe  phoneNumber=1234567890  email=                      password=password    field_status=False  field_message=Please fill out this field.
&{user_withoutPasswordInfo}       field_id=passwordCreate  firstName=John  lastName=Doe  phoneNumber=1234567890  email=jane.doe@example.com  password=            field_status=False  field_message=Please fill out this field.
&{user_withWrongPhoneFormatInfo}  field_id=phone           firstName=John  lastName=Doe  phoneNumber=123         email=jane.doe@example.com  password=password    field_status=False  field_message=Please match the requested format.
&{user_withWrongEmailFormatInfo}  field_id=emailCreate     firstName=John  lastName=Doe  phoneNumber=1234567890  email=@mail.com             password=password    field_status=False  field_message=Please enter a part followed by '@'. '@mail.com' is incomplete.
&{user_withEmailInputMissmatch}   field_id=emailCreate     firstName=John  lastName=Doe  phoneNumber=1234567890  email01=@mail.com           password=password    field_status=False  field_message=Please enter a part followed by '@'. '@mail.com' is incomplete.   email02=123@
&{user_withPasswordInputMissmatch}  field_id=signInError   firstName=John  lastName=Doe  phoneNumber=1234567890  email=foo3@mail.com         password01=password  field_status=       field_message=Passwords must match  password02=123456

*** Keywords ***
User navigate to rental page and logs in with valid credentials
    [Arguments]    ${user_info}
    Open Browser   ${URL}   Chrome
    Input Text    id=email    ${user_info['email']}
    Input Text    id=password    ${user_info['password']}
    Click Button    id=login

User chooses rental date and rental car
    Wait Until Page Contains Element    id=start
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    Execute JavaScript    document.getElementById('start').value='${current_date}'
    Execute JavaScript    document.getElementById('end').value='${current_date}'
    Click Button    id=continue
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${expectedText}=    Set Variable    Selected trip dates: ${current_date} – ${current_date}
    Wait Until Element Is Visible    xpath=//*[@id="showQuestion"]/label    timeout=30s
    ${actualText}=    Get Text    xpath=//*[@id="showQuestion"]/label
    Should Be Equal As Strings    ${actualText}    ${expectedText}
    Click Button    xpath=//*[@id="bookQ7pass7"]
    ${expectedText}    Set Variable    Confirm booking of Audi Q7
    Wait Until Element Is Visible    id=questionText    timeout=30s
    ${actualText}=    Get Text    id=questionText
    Should Be Equal As Strings    ${actualText}    ${expectedText}

The booking should be succesful
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    Input Text    id=cardNum    1234567891234567
    Input Text    id=fullName    Jane Doe
    Click Element    id=month1
    Click Element    id=month2018
    Input Text    id=cvc    000
    Click Button    id=confirm
    ${expectedText}    Set Variable    A Audi Q7 is now ready for pickup ${current_date}
    Wait Until Element Is Visible    xpath=//*[@id="questionTextSmall"]    timeout=30s
    ${actualText}=    Get Text    xpath=//*[@id="questionTextSmall"]
    Should Be Equal As Strings    ${actualText}    ${expectedText}

Unbook1
    [Tags]    Cleanup
    Click Button    id=mypage
    Click Button    id=unBook1
    Handle Alert    ACCEPT
    Wait Until Page Contains    Your car: ERB203 has been Returned
    Close Browser

Unbook2
   [Tags]  Cleanup
   Click Button    id=mypage
   Click Button    id=unBook1
   Handle Alert    ACCEPT
   Wait Until Page Contains    Your car: BWE530 has been Returned
   Close Browser

Confirm booking with valid input
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${expectedText}   Set Variable  A Volvo V40 is now ready for pickup ${current_date}
    Wait Until Element Is Visible    xpath=//*[@id="questionTextSmall"]  timeout=30s
    ${actualText}=    Get Text    xpath=//*[@id="questionTextSmall"]
    Should Be Equal As Strings    ${actualText}    ${expectedText}
    Page Should Contain Button    id=home
    Page Should Contain Button    id=mypage
    Booking added to database table

Confirm Home button function
    Page Should Contain Button    id=home
    Click Button    id=home
    Wait Until Element Is Visible  id=questionText    timeout=20s
    ${expectedText}=  Set Variable  When do you want to make your trip?
    ${actualText}=    Get Text    id=questionText
    Should Be Equal As Strings    ${actualText}    ${expectedText}

Confirm My page button function
    Click Button    id=mypage
    Wait Until Element Is Visible  id=historyText    timeout=20s
    ${expectedText}=  Set Variable  My bookings
    ${actualText}=    Get Text    id=historyText
    Should Be Equal As Strings    ${actualText}    ${expectedText}

Confirm Refresh Error Message
    Reload Page
    Wait Until Page Contains Element  id=questionTextSmall  timeout=20s
    ${expectedText}=  Set Variable  Unfortunately your selected car became unavailable during your booking. Please go back to car selection and try again.
    ${actualText}=    Get Text    id=questionTextSmall
    Should Be Equal As Strings    ${actualText}    ${expectedText}

Navigate to page
    [Tags]  Navigation
    Open Browser  ${URL}  Chrome
    Input Text    id=email  ${user2['email']}
    Input Text    id=password  ${user2['password']}
    Click Button    id = login
    Wait Until Page Contains Element    id=start
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    Execute JavaScript    document.getElementById('start').value='${current_date}'
    Execute JavaScript    document.getElementById('end').value='${current_date}'
    Click Button  id=continue
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    Click Button    id=bookV40pass5
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    Input Text    id=cardNum  1234567891234567
    Input Text    id=fullName  Jane Doe
    Click Element    id=month1
    Click Element    id=month2018
    Input Text       id=cvc   000
    Click Button    id=confirm

Booking added to database table
   [Tags]  Booking
   ${current_date}=    Get Current Date    result_format=%Y-%m-%d
   Click Button    id=mypage
   Wait Until Element Is Visible  id=historyText    timeout=20s
   ${expectedText}=  Set Variable  BWE530
   ${actualText}=    Get Text    id=licenseNumber1
   Should Be Equal As Strings    ${actualText}    ${expectedText}
   ${expectedText}=  Set Variable  ${current_date}
   ${actualText}=    Get Text    id=startDate1
   Should Be Equal As Strings    ${actualText}    ${expectedText}
   ${expectedText}=  Set Variable  ${current_date}
   ${actualText}=    Get Text    id=endDate1
   Should Be Equal As Strings    ${actualText}    ${expectedText}

Create user with valid input
    [Arguments]    ${user_data}
    Run Keyword    Userinfo Into Field     ${user_data}
    Wait Until Page Contains Element    id=welcomePhrase    timeout=10s    error=Page did not contain welcome phrase
    Element Text Should Be    id=welcomePhrase    You are signed in as ${user_data['firstName']}    timeout=10s    error=Welcome phrase did not match expected value
    Close Browser

Userinfo Into Field
    [Arguments]    ${user_data}
    [Tags]  UserCreation

    Input Text    id=name    ${user_data['firstName']}
    Input Text    id=last    ${user_data['lastName']}
    Input Text    id=phone    ${user_data['phoneNumber']}
    IF      ${user_data} == ${user_withEmailInputMissmatch}
        Input Text    id=emailCreate    ${user_data['email01']}
        Input Text    id=confirmEmail    ${user_data['email02']}
        Input Text    id=passwordCreate    ${user_data['password']}
        Input Text    id=confirmPassword    ${user_data['password']}
        Click Button  id=create
    ELSE IF  ${user_data} == ${user_withPasswordInputMissmatch}
        Input Text    id=emailCreate    ${user_data['email']}
        Input Text    id=confirmEmail    ${user_data['email']}
        Input Text    id=passwordCreate    ${user_data['password01']}
        Input Text    id=confirmPassword    ${user_data['password02']}
        Click Button  id=create
    ELSE
        Input Text    id=emailCreate    ${user_data['email']}
        Input Text    id=confirmEmail    ${user_data['email']}
        Input Text    id=passwordCreate    ${user_data['password']}
        Input Text    id=confirmPassword    ${user_data['password']}
        Click Button  id=create
    END

Navigate To Create User Page
    Open Browser    ${URL}    Chrome
    Wait Until Element Is Visible    id=title
    Element Text Should Be    id=title    Infotiv Car Rental    timeout=10s    error=Title text does not match expected value
    Click Button    id=createUser
    Wait Until Page Contains Element    id=questionText
    Element Text Should Be    id=questionText    Create a new user    timeout=10s    error=Title text does not match expected value

Confirm Field Alert
    [Arguments]   ${user_data}
    [Tags]  FieldValidation
    Wait Until Page Contains Element    id=emailCreate  timeout=30
    ${expected_field_status}=    Evaluate    ${user_data['field_status']}
    ${actual_field_status}=    Execute JavaScript    return document.getElementById('${user_data['field_id']}').validity.valid
    Should Be Equal    ${actual_field_status}    ${expected_field_status}
    ${expected_field_message}=    Set Variable    ${user_data['field_message']}
    ${actual_field_message}=    Execute JavaScript    return document.getElementById('${user_data['field_id']}').validationMessage
    Should Be Equal As Strings    ${actual_field_message}    ${expected_field_message}
    Close Browser

Confirm Error Message
    [Tags]  ErrorValidation
    Wait Until Page Contains Element    id=signInError  timeout=30
    Element Should Be Visible    id=signInError
    ${expected_field_message}  Set Variable   ${user_withPasswordInputMissmatch['field_message']}
    ${actual_field_message}=    Get Text    id=signInError
    Should Be Equal As Strings    ${actual_field_message}   ${expected_field_message}
    Close Browser

 Click Cancel button
    Click Button    id=cancel
    Wait Until Page Contains Element    id=questionText
    Element Text Should Be    id=questionText    When do you want to make your trip?    timeout=10s    error=Title text does not match expected value
    Close Browser
