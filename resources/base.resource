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
