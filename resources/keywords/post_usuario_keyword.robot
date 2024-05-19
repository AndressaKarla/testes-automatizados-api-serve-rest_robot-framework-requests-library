*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections
Resource    ../../resources/base.resource


*** Variables ***
${message_esperada}     Cadastro realizado com sucesso


*** Keywords ***
Gerar email
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL}    ${palavra_aleatoria}@gmail.com
    Log    ${EMAIL}

POST usuario (administrador)
    [Arguments]    ${EMAIL}
    ${body}    Create Dictionary
    ...    nome=Usuário Admin
    ...    email=${EMAIL}
    ...    password=teste1234
    ...    administrador=true
    Log    ${body}

    Iniciar sessão

    ${response_post_usuario}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=201

    Log    ${response_post_usuario.json()}

    Set Test Variable    ${RESPONSE_POST_USUARIO}    ${response_post_usuario}
    Set Test Variable    ${JSON_DATA_POST_USUARIO}    ${response_post_usuario.json()}

Validar status 201 Created e dados retornados com sucesso
    Log    ${JSON_DATA_POST_USUARIO}
    Should Be Equal    ${RESPONSE_POST_USUARIO.status_code}    ${201}
    Should Be Equal As Strings    Created    ${RESPONSE_POST_USUARIO.reason}
    Dictionary Should Contain Item    ${JSON_DATA_POST_USUARIO}    message    ${message_esperada}
    Dictionary Should Contain Key    ${JSON_DATA_POST_USUARIO}    _id
