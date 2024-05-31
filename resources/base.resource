*** Settings ***
Documentation       Arquivo base com inicializações

Library             RequestsLibrary
Resource            env.resource
Variables           environments/${ENV}.json


*** Variables ***
${URI}      ${base_uri}


*** Keywords ***
Iniciar sessão
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServeRest    url=${URI}    headers=${headers}    disable_warnings=1

Obter por email e excluir usuario por id
    [Arguments]    ${email_usuario}
    ${retorno_get_email_usuario}    GET On Session
    ...    alias=ServeRest
    ...    url=/usuarios?email=${email_usuario}
    ...    expected_status=200

    IF    ${retorno_get_email_usuario.json()['quantidade']} == 1
        Set Local Variable    ${ID_USUARIO_RETORNADO}    ${retorno_get_email_usuario.json()['usuarios'][0]['_id']}

        ${retorno_delete_usuario}    DELETE On Session
        ...    alias=ServeRest
        ...    url=/usuarios/${ID_USUARIO_RETORNADO}
        ...    expected_status=200
    END
