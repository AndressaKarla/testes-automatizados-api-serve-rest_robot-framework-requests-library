*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     FakerLibrary    locale=pt_br


*** Variables ***
${ALIAS}    API_serverest


*** Keywords ***
Iniciar sessão
    ${HEADERS}    Create Dictionary    Content-Type=application/json
    Create Session    alias=${ALIAS}    url=https://serverest.dev    headers=${HEADERS}    disable_warnings=1

Gerar dados aleatórios do usuário
    ${NOME}    FakerLibrary.First Name
    ${SOBRENOME}    FakerLibrary.Last Name
    ${EMAIL}    FakerLibrary.Email
    ${SENHA}    FakerLibrary.Password
    ${USUARIO}    Create Dictionary
    ...    nome=${NOME} ${SOBRENOME}
    ...    email=${EMAIL}
    ...    senha=${SENHA}
    Set Suite Variable    ${USUARIO}

POST usuario (administrador)
    Gerar dados aleatórios do usuário
    ${BODY}    Create Dictionary
    ...    nome=${USUARIO.nome}
    ...    email=${USUARIO.email}
    ...    password=${USUARIO.senha}
    ...    administrador=true
    ${RESPONSE}    POST On Session    alias=${ALIAS}    url=usuarios    json=${BODY}
    Log    Resposta Retornada: ${\n}${RESPONSE.text}
