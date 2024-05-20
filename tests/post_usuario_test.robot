*** Settings ***
Resource    ../resources/keywords/post_usuario_keyword.robot


*** Test Cases ***
POST usuário (administrador) - Validar status 201 Created e dados retornados com sucesso
    Gerar dados usuário
    POST usuário (administrador)    nome_sobrenome=${NOME_SOBRENOME}    email=${EMAIL}    senha=${SENHA}
    Validar status 201 Created e dados retornados com sucesso
