*** Settings ***
Resource    ../resources/keywords/post_usuario_keyword.robot


*** Test Cases ***
POST usuario (administrador) - Validar status 201 Created e dados retornados com sucesso
    Gerar email
    POST usuario (administrador)    email=${EMAIL_TESTE}
    Validar status 201 Created e dados retornados com sucesso
