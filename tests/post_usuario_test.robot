*** Settings ***
Resource        ../resources/keywords/post_usuario_keyword.robot

Test Setup      Iniciar sessão


*** Test Cases ***
POST usuario (administrador) - Validar dados retornados com sucesso
    POST usuario (administrador)
