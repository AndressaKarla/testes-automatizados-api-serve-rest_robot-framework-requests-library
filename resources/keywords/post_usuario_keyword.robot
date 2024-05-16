*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections


*** Keywords ***
Iniciar sessão
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}    disable_warnings=1

Gerar email
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@gmail.com
    Log    ${EMAIL_TESTE}

POST usuario (administrador)
    [Arguments]    ${email}
    ${body}    Create Dictionary
    ...    nome=Usuário Admin
    ...    email=${email}
    ...    password=teste1234
    ...    administrador=true
    Log    ${body}

    Iniciar sessão

    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=201

    Log    ${resposta.json()}

    Set Test Variable    ${RESPOSTA}

Validar status 201 Created e dados retornados com sucesso
    Log    ${RESPOSTA.json()}
    Should Be Equal    ${RESPOSTA.status_code}    ${201}
    Should Be Equal As Strings    Created    ${RESPOSTA.reason}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA.json()}    _id
