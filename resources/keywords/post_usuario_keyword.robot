*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections
Library     ../../resources/helpers.py
Resource    ../../resources/base.resource


*** Variables ***
${message_esperada}     Cadastro realizado com sucesso


*** Keywords ***
Gerar nome e sobrenome usuário
    ${nome_sobrenome}    Gerar Nome Sobrenome
    Set Test Variable    ${NOME_SOBRENOME}    ${nome_sobrenome}

Gerar email usuário
    ${email}    Gerar Email    ${NOME_SOBRENOME}
    Set Test Variable    ${EMAIL}    ${email}

Gerar senha usuário
    ${senha}    Gerar Senha
    Set Test Variable    ${SENHA}    ${senha}

Gerar dados usuário
    Gerar nome e sobrenome usuário
    Gerar email usuário
    Gerar senha usuário

POST usuário (administrador)
    [Arguments]    ${nome_sobrenome}    ${email}    ${senha}
    ${body}    Create Dictionary
    ...    nome=${nome_sobrenome}
    ...    email=${email}
    ...    password=${senha}
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
