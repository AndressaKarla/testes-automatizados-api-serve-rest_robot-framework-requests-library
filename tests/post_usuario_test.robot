*** Settings ***
Resource        ../resources/keywords/post_usuario_keyword.robot

Test Setup      Iniciar sessão


*** Test Cases ***
POST usuário (administrador) dinâmico - Validar status 201 Created e dados retornados com sucesso
    [Tags]    post_usuario_admin_din
    Gerar dados usuário dinâmico
    POST usuário (administrador)    nome_sobrenome=${NOME_SOBRENOME}    email=${EMAIL}    senha=${SENHA}
    Validar status 201 Created e dados retornados com sucesso
    Obter por email e excluir usuario por id    email_usuario=${EMAIL}

POST usuário (administrador) - Validar status 201 Created e dados retornados com sucesso
    [Tags]    post_usuario_admin    regressao
    Obter dados usuário admin estático
    Obter por email e excluir usuario por id    email_usuario=${EMAIL}
    POST usuário (administrador)    nome_sobrenome=${NOME_SOBRENOME}    email=${EMAIL}    senha=${SENHA}
    Validar status 201 Created e dados retornados com sucesso
