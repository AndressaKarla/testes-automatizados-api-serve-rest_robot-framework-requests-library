*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections
Library     ../../resources/helpers.py
Resource    ../../resources/base.resource


*** Variables ***
${message_esperada}     Cadastro realizado com sucesso


*** Keywords ***
Gerar nome e sobrenome usuário dinâmico
    ${nome_sobrenome}    Gerar Nome Sobrenome
    Set Test Variable    ${NOME_SOBRENOME}    ${nome_sobrenome}

Gerar email usuário dinâmico
    ${email}    Gerar Email    ${NOME_SOBRENOME}
    Set Test Variable    ${EMAIL}    ${email}

Gerar senha usuário dinâmico
    ${senha}    Gerar Senha
    Set Test Variable    ${SENHA}    ${senha}

Gerar dados usuário dinâmico
    Gerar nome e sobrenome usuário dinâmico
    Gerar email usuário dinâmico
    Gerar senha usuário dinâmico

Carregar usuário fixture
    ${usuario_fixture}    Carregar Fixture    usuario
    Set Test Variable    ${USUARIO_FIXTURE}    ${usuario_fixture}

    Log    ${USUARIO_FIXTURE}

Obter nome e sobrenome usuário estático
    Set Test Variable    ${NOME_SOBRENOME}    ${USUARIO_FIXTURE['admin_valido']['nome_sobrenome_valido']}

Obter email usuário estático
    Set Test Variable    ${EMAIL}    ${USUARIO_FIXTURE['admin_valido']['email_valido']}

Obter senha usuário estático
    Set Test Variable    ${SENHA}    ${USUARIO_FIXTURE['admin_valido']['senha_valida']}

Obter dados usuário estático
    Carregar usuário fixture
    Obter nome e sobrenome usuário estático
    Obter email usuário estático
    Obter senha usuário estático

POST usuário (administrador)
    [Arguments]    ${nome_sobrenome}    ${email}    ${senha}
    ${body}    Create Dictionary
    ...    nome=${nome_sobrenome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=true
    Log    ${body}

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
