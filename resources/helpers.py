import random, re
from unicodedata import normalize
from faker import Faker

def gerar_nome_sobrenome():
    nome = [
        "Alice",
        "Amanda",
        "Ana",
        "André",
        "Anthony",
        "Arthur",
        "Augusto",
        "Beatriz",
        "Benjamin",
        "Bernardo",
        "Bianca",
        "Breno",
        "Caio",
        "Camila",
        "Carla",
        "Carolina",
        "Catarina",
        "Cecília",
        "Clara",
        "Daniel",
        "Davi",
        "Diego",
        "Eduardo",
        "Emanuelly",
        "Enzo",
        "Evelyn",
        "Fábio",
        "Felipe",
        "Fernando",
        "Francisco",
        "Gabriel",
        "Gabriela",
        "Guilherme",
        "Gustavo",
        "Helena",
        "Henrique",
        "Isabel",
        "Isabela",
        "Isabella",
        "Isadora",
        "Joana",
        "João",
        "Júlia",
        "Juliana",
        "Kevin",
        "Laís",
        "Lara",
        "Larissa",
        "Laura",
        "Lavinia",
        "Leonardo",
        "Letícia",
        "Lívia",
        "Lorena",
        "Lorenzo",
        "Luana",
        "Lucas",
        "Lucca",
        "Luciano",
        "Luiza",
        "Luna",
        "Manuela",
        "Marcelo",
        "Maria",
        "Mariana",
        "Mariane",
        "Melissa",
        "Miguel",
        "Mirella",
        "Murilo",
        "Natália",
        "Nathália",
        "Nicolas",
        "Otávio",
        "Paulo",
        "Pedro",
        "Pietra",
        "Rafael",
        "Raul",
        "Rebeca",
        "Ricardo",
        "Roberto",
        "Rodrigo",
        "Ruan",
        "Samuel",
        "Sofia",
        "Sophia",
        "Stella",
        "Thiago",
        "Tomás",
        "Valentina",
        "Vinícius",
        "Vitor",
        "Vitória",
        "Yasmin"
    ]

    nome_aleatorio = nome[random.randint(0, len(nome))]

    sobrenome = [
        "Abreu",
        "Aguiar",
        "Albuquerque",
        "Almeida",
        "Alves",
        "Andrade",
        "Araújo",
        "Azevedo",
        "Barbosa",
        "Barros",
        "Batista",
        "Borges",
        "Braga",
        "Campos",
        "Cardoso",
        "Carneiro",
        "Carvalho",
        "Castro",
        "Cavalcante",
        "Cavalcanti",
        "Coelho",
        "Correia",
        "Costa",
        "Coutinho",
        "Cruz",
        "Cunha",
        "Dantas",
        "Dias",
        "Farias",
        "Fernandes",
        "Ferreira",
        "Fialho",
        "Figueiredo",
        "Fonseca",
        "Freitas",
        "Furtado",
        "Gomes",
        "Gonçalves",
        "Goulart",
        "Gusmão",
        "Leite",
        "Lemos",
        "Lima",
        "Lopes",
        "Macedo",
        "Machado",
        "Marques",
        "Martins",
        "Melo",
        "Mendes",
        "Monteiro",
        "Moraes",
        "Morais",
        "Moreira",
        "Moura",
        "Neves",
        "Nogueira",
        "Nunes",
        "Oliveira",
        "Pacheco",
        "Peixoto",
        "Pereira",
        "Pires",
        "Prado",
        "Ramos",
        "Rezende",
        "Ribeiro",
        "Rocha",
        "Rodrigues",
        "Sales",
        "Sampaio",
        "Santos",
        "Saraiva",
        "Silva",
        "Silveira",
        "Sousa",
        "Souza",
        "Tavares",
        "Teixeira",
        "Valente",
        "Vargas",
        "Vieira",
        "Xavier"
    ]

    sobrenome_aleatorio = sobrenome[random.randint(0, len(sobrenome))]

    nome_sobrenome = nome_aleatorio + " " + sobrenome_aleatorio

    return nome_sobrenome

def gerar_email(nome_sobrenome):
    dominio_email = [
        "@gmail.com",
        "@outlook.com",
        "@yahoo.com",
        "@icloud.com",
        "@protonmail.com",
        "@hotmail.com.br"
    ]

    dominio_email_aleatorio = dominio_email[random.randint(0, len(dominio_email))]

    nome_sobrenome = nome_sobrenome.lower()

    # regex (expressão regular) para substituir os espaços "\s" por ponto "."
    nome_sobrenome = re.sub(r'[/\s/]', '.', nome_sobrenome)

    # normalização que separa os caracteres acentuados e com sinais gráficos em seus componentes de caracteres básicos
	# ex.: a letra acentuada "á" seria separada em "a" sem acento e um acento agudo "´"
    nome_sobrenome = normalize('NFD', nome_sobrenome)

    # regex para substituir toda a faixa "\u0300-\u036f" que engloba a maioria dos acentos e sinais gráficos por uma string vazia
    nome_sobrenome_normalizado = re.sub(r'[\u0300-\u036f]', '', nome_sobrenome)
    
    email = nome_sobrenome_normalizado + dominio_email_aleatorio

    return email 

def gerar_senha():
    senha = Faker().password()

    return senha